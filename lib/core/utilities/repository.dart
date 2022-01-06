import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/sort_order.util.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

import 'query_expression.dart';

abstract class BaseRepository<T extends BaseEntity> {
  List<Column> get columns;
  Entity get entity;
  String get createQuery;
  Future<Database> get database;
  Future<dynamic> create({Database database});
  Future<List<T>> find(
      {String? id,
      List<QueryFilter>? filters,
      List<String>? fields,
      Map<String, SortOrder>? sortOrder,
      Database? database});
  Future<T?> findById(
      {required String id, List<String>? fields, Database? database});
  Future<List<T>> findAll(
      {List<QueryFilter> filters,
      List<String> fields,
      Map<String, SortOrder> sortOrder});
  Future<int> insertOne({required T entity, Database? database});
  Future<int> insertMany({required List<T> entities, Database? database});
  Future<int> updateOne({required T entity, Database database});
  Future<int> updateMany({required List<T> entities, Database database});
  Future<int> saveMany({required List<T> entities, Database database});
  Future<int> saveOne({required T entity, Database database});
  Future<int> deleteById({required String id, Database database});
  Future<int> deleteByIds({required List<String> ids, Database database});
  Future<int> deleteAll({Database database});
  Future<void> clear({Database database});
  Map<String, dynamic> sanitizeIncomingData(Map<String, dynamic> entity);
}

class Repository<T extends BaseEntity> extends BaseRepository<T> {
  @override
  Future<Database> get database => DatabaseManager.instance.database;

  @override
  Future<void> clear({Database? database}) async {
    final Database db = database != null ? database : await this.database;
  }

  @override
  Future<List<T>> findAll(
      {List<QueryFilter>? filters,
      List<String>? fields,
      Map<String, SortOrder>? sortOrder,
      Database? database,
      List<ColumnRelation>? relations}) async {
    final Database db = database != null ? database : await this.database;
    return this.find(
        filters: filters,
        fields: fields,
        sortOrder: sortOrder,
        database: db,
        relations: relations);
  }

  @override
  Future<List<T>> find(
      {String? id,
      List<QueryFilter>? filters,
      List<String>? fields,
      Map<String, SortOrder>? sortOrder,
      Database? database,
      List<ColumnRelation>? relations}) async {
    final Database db = database != null ? database : await this.database;

    if (id != null) {
      final queryResult = (await db.query(this.entity.tableName,
          where: 'id = ?', whereArgs: [id], columns: fields));

      final relationResults = await this.findRelations(
          database: db,
          relations: relations,
          data: queryResult.length > 0 ? queryResult[0] : null);

      final dataResult = queryResult.map((result) {
        Map<String, dynamic> resultMap = {...result};

        this.columns.forEach((column) {
          final key = column.name;
          final relationElement =
              (relationResults != null ? relationResults : [])
                  .where((relationResult) => relationResult['attribute'] == key)
                  .toList();

          if (relationElement.length > 0) {
            resultMap[relationElement[0]['attribute']] =
                relationElement[0]['data'];
          } else {
            resultMap[key as String] = result[key];
          }
        });

        return getObject<T>(resultMap);
      }).toList();

      return dataResult;
    }

    final String? whereParameters = QueryFilter.getWhereParameters(filters);
    final String? orderParameters =
        SortOrderUtil.getSortOrderParameters(sortOrder);

    if (whereParameters == null) {
      return (await db.query(this.entity.tableName,
              orderBy: orderParameters, columns: fields))
          .map((e) {
        return getObject<T>(e);
      }).toList();
    }

    return findWhere(
        database: db,
        whereParameters: whereParameters,
        orderParameters: orderParameters);
  }

  Future<List?> findRelations(
      {Database? database,
      List<ColumnRelation>? relations,
      dynamic data}) async {
    if (relations == null || relations.length == 0 || data == null) {
      return null;
    }

    return Future.wait(relations.map((relation) async {
      // TODO Find best way to deal with other relationships;
      final referencedValue = data[
          relation.relationType == RelationType.OneToMany
              ? relation.primaryKey
              : relation.attributeName];
      final Database db = database != null ? database : await this.database;

      final whereParameters =
          '${relation.referencedColumn} = "$referencedValue"';

      final relationResult = (await db.query(
              relation.referencedEntity?.tableName as String,
              where: whereParameters))
          .toList();

      Map<String, dynamic> resultMap = {};
      resultMap['attribute'] = relation.attributeName;

      final dataResult = (relation.relationType == RelationType.ManyToOne
          ? relationResult.length > 0
              ? relationResult[0]
              : null
          : relationResult);
      resultMap['data'] = dataResult;

      return resultMap;
    }));
  }

  Future<List<T>> findWhere({
    Database? database,
    String? whereParameters,
    String? orderParameters,
    List<String>? fields,
  }) async {
    final Database db = database != null ? database : await this.database;
    return (await db.query(this.entity.tableName,
            where: whereParameters, orderBy: orderParameters, columns: fields))
        .map((e) {
      return getObject<T>(e);
    }).toList();
  }

  @override
  Future<T?> findById(
      {required String id,
      List<String>? fields,
      Database? database,
      List<ColumnRelation>? relations}) async {
    final Database db = database != null ? database : await this.database;

    var results = await this.find(id: id, fields: fields, database: db);

    return results.length > 0 ? results[0] : null;
  }

  @override
  Future<int> insertMany(
      {required List<T> entities, Database? database}) async {
    final Database db = database != null ? database : await this.database;

// TODO
    await Future.forEach(
        entities, ((T entity) => insertOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> insertOne({required T entity, Database? database}) async {
    Map<String, dynamic> data = this.sanitizeIncomingData(entity.toJson());
    final Database db = database != null ? database : await this.database;
    return db.insert(this.entity.tableName, data);
  }

  @override
  Future<int> deleteByIds(
      {required List<String> ids, Database? database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName,
        where: 'id IN (?)', whereArgs: [ids.join(',')]);

    return 1;
  }

  @override
  Future<int> deleteById({required String id, Database? database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName, where: 'id = ?', whereArgs: [id]);

    return 1;
  }

  @override
  Future<int> deleteAll({Database? database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName);

    return 1;
  }

  @override
  Future<int> saveMany({required List<T> entities, Database? database}) async {
    final Database db = database != null ? database : await this.database;

//TODO
    await Future.forEach(
        entities, ((T entity) => saveOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> saveOne({required T entity, Database? database}) async {
    final Database db = database != null ? database : await this.database;

    var result = await this.findById(id: entity.id, database: db);

    if (result != null) {
      return this.updateOne(entity: entity, database: db);
    }

    return this.insertOne(entity: entity, database: db);
  }

  @override
  Future<int> updateMany(
      {required List<T> entities, Database? database}) async {
    final Database db = database != null ? database : await this.database;

//TODO
    await Future.forEach(
        entities, ((T entity) => updateOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> updateOne({required T entity, Database? database}) async {
    Map<String, dynamic> data = this.sanitizeIncomingData(entity.toJson());
    final Database db = database != null ? database : await this.database;
    return db.update(
      this.entity.tableName,
      data,
      where: "id = ?",
      whereArgs: [data['id']],
    );
  }

  @override
  List<Column> get columns => Entity.getEntityColumns(
      AnnotationReflectable.reflectType(T) as ClassMirror);

  @override
  String get createQuery => QueryExpression.getCreateTableExpression(
      this.entity.tableName, this.columns);

  @override
  Future create({Database? database}) async {
    final Database db = database != null ? database : await this.database;
    return db.execute(this.createQuery);
  }

  @override
  Entity get entity {
    return Entity.getEntityDefinition(
        AnnotationReflectable.reflectType(T) as ClassMirror);
  }

  @override
  Map<String, dynamic> sanitizeIncomingData(Map<String, dynamic> entity) {
    Map<String, dynamic> data = new Map();
    this.columns.forEach((column) {
      if (column.type == ColumnType.BOOLEAN) {
        data[column.name as String] =
            entity[column.attributeName] == true ? 1 : 0;
      } else if (column.relation != null) {
        final entityByAttribute = entity[column.attributeName];

        if (entityByAttribute != null) {
          data[column.name as String] =
              entityByAttribute[column.relation?.referencedColumn];
        }
      } else if (entity[column.attributeName] is List) {
        data[column.name as String] = entity[column.attributeName].toString();
      } else {
        data[column.name as String] = entity[column.attributeName];
      }
    });

    return data;
  }

  T getObject<T>(Map<String, dynamic> objectMap) {
    Map<String, dynamic> resultMap = {};

    this.columns.forEach((column) {
      var value = objectMap[column.name];
      if (value.runtimeType == int && column.type == ColumnType.BOOLEAN) {
        resultMap[column.name as String] = value == 1 ? true : false;
      } else if (column.relation != null) {
        resultMap[column.name as String] = getRelationObject(
            relation: column.relation as ColumnRelation, value: value);
      } else {
        resultMap[column.name as String] = value;
      }
    });
    ClassMirror classMirror =
        AnnotationReflectable.reflectType(T) as ClassMirror;
    return classMirror.newInstance('fromJson', [resultMap]) as T;
  }

  getRelationObject({required ColumnRelation relation, dynamic value}) {
    if (value == null) {
      return null;
    }
    switch (relation.relationType) {
      case RelationType.ManyToOne:
        Map<String, dynamic> relationMap = {};

        relation.referencedEntityColumns?.forEach((column) {
          var relationValue = value[column!.name];
          if (relationValue.runtimeType == int &&
              column.type == ColumnType.BOOLEAN) {
            relationMap[column.name as String] =
                relationValue == 1 ? true : false;
          } else {
            relationMap[column.name as String] = relationValue;
          }
        });

        return relation.referencedEntity?.classMirror!
            .newInstance('fromJson', [relationMap]);

      case RelationType.OneToMany:
        return value.toList().map((valueItem) {
          Map<String, dynamic> relationMap = {};

          // relation.referencedEntityColumns.forEach((column) {
          //   var relationValue = value[column.name];
          //   if (relationValue.runtimeType == int &&
          //       column.type == ColumnType.BOOLEAN) {
          //     relationMap[column.name] = relationValue == 1 ? true : false;
          //   } else {
          //     relationMap[column.name] = relationValue;
          //   }
          // });

          return relation.referencedEntity?.classMirror!
              .newInstance('fromJson', [value]);
        });

      default:
        return null;
    }
  }
}

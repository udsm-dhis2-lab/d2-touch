import 'dart:convert';

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/sort_order.util.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

import 'query_expression.dart';

abstract class BaseRepository<T extends BaseEntity> {
  List<Column> get columns;
  List<Column> get oneToManyColumns;
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
  Map<String, dynamic> sanitizeIncomingData(
      {required Map<String, dynamic> entity, required List<Column> columns});
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

    final String? whereParameters =
        QueryFilter.getWhereParameters(this.columns, filters);
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
    Map<String, dynamic> data = this
        .sanitizeIncomingData(entity: entity.toJson(), columns: this.columns);
    final Database db = database != null ? database : await this.database;
    final saveDataResponse = db.insert(this.entity.tableName, data);

    if (this.oneToManyColumns.isEmpty) {
      return saveDataResponse;
    }

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    this.oneToManyColumns.forEach((Column column) {
      final List data = entity.toJson()[column.relation?.attributeName];
      if (data.isNotEmpty) {
        availableItemCount++;
        data.forEach((dataItem) {
          queue.add(() => insertRelationData(
              columnRelation: column.relation as ColumnRelation,
              entity: dataItem,
              database: db));
        });
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
      return saveDataResponse;
    }

    await queue.onComplete;
    return saveDataResponse;
  }

  Future insertRelationData(
      {required ColumnRelation columnRelation,
      required BaseEntity entity,
      Database? database}) async {
    Map<String, dynamic> data = this.sanitizeIncomingData(
        entity: entity.toJson(),
        columns: columnRelation.referencedEntityColumns as List<Column>);
    final Database db = database != null ? database : await this.database;

    final saveDataResponse =
        db.insert(columnRelation.referencedEntity?.tableName as String, data);

    final List<Column?>? oneToManyColumns = columnRelation
        .referencedEntityColumns
        ?.where((column) =>
            column?.relation?.relationType == RelationType.OneToMany)
        .toList();

    if (oneToManyColumns!.isEmpty) {
      return saveDataResponse;
    }

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    oneToManyColumns.forEach((Column? column) {
      final List data = entity.toJson()[column?.relation?.attributeName];
      if (data.isNotEmpty) {
        availableItemCount++;
        data.forEach((dataItem) {
          queue.add(() => insertRelationData(
              columnRelation: column?.relation as ColumnRelation,
              entity: dataItem,
              database: db));
        });
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
      return saveDataResponse;
    }

    await queue.onComplete;

    return saveDataResponse;
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
  Future<int> saveMany(
      {required List<T> entities, Database? database, int? chunk}) async {
    final Database db = database != null ? database : await this.database;

    final queue = Queue(parallel: chunk ?? 50);

    entities.forEach((T entity) {
      queue.add(() => saveOne(entity: entity, database: db));
    });

    await queue.onComplete;

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
      {required List<T> entities, Database? database, int? chunk}) async {
    final Database db = database != null ? database : await this.database;

    final queue = Queue(parallel: chunk ?? 50);

    entities.forEach((T entity) {
      queue.add(() => updateOne(entity: entity, database: db));
    });

    await queue.onComplete;

    return 1;
  }

  @override
  Future<int> updateOne({required T entity, Database? database}) async {
    Map<String, dynamic> data = this
        .sanitizeIncomingData(entity: entity.toJson(), columns: this.columns);
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
      AnnotationReflectable.reflectType(T) as ClassMirror, false);

  @override
  List<Column> get oneToManyColumns => this
      .columns
      .where(
          (column) => column.relation?.relationType == RelationType.OneToMany)
      .toList();

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
  Map<String, dynamic> sanitizeIncomingData(
      {required Map<String, dynamic> entity, required List<Column> columns}) {
    Map<String, dynamic> data = new Map();
    columns.forEach((column) {
      if (column.type == ColumnType.BOOLEAN) {
        data[column.name as String] =
            entity[column.attributeName] == true ? 1 : 0;
      } else if (column.relation != null) {
        if (column.relation?.relationType != RelationType.OneToMany) {
          final entityByAttribute = entity[column.attributeName];

          if (entityByAttribute != null) {
            data[column.name as String] =
                entityByAttribute.runtimeType == String
                    ? entityByAttribute
                    : entityByAttribute[column.relation?.referencedColumn];
          }
        }
      } else {
        if (entity[column.attributeName] is List) {
          data[column.name as String] = entity[column.attributeName].toString();
        } else {
          data[column.name as String] = entity[column.attributeName];
        }
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
        resultMap[column.name as String] =
            column.relation?.relationType == RelationType.OneToMany
                ? getRelationObject(
                    relation: column.relation as ColumnRelation, value: value)
                : value;
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
          return relation.referencedEntity?.classMirror!
              .newInstance('fromJson', [valueItem]);
        });

      default:
        return null;
    }
  }
}

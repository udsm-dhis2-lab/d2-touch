import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/sort_order.util.dart';
import 'package:flutter/foundation.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

import 'annotations/reflectable.annotation.dart';
import 'query_expression.dart';

abstract class BaseRepository<T extends BaseEntity> {
  List<Column> get columns;
  Entity get entity;
  String get createQuery;
  Future<Database> get database;
  Future<dynamic> create({Database database});
  Future<List<T>> find(
      {String id,
      List<QueryFilter> filters,
      List<String> fields,
      Map<String, SortOrder> sortOrder,
      Database database});
  Future<T> findById(
      {@required String id, List<String> fields, Database database});
  Future<List<T>> findAll(
      {List<QueryFilter> filters,
      List<String> fields,
      Map<String, SortOrder> sortOrder});
  Future<int> insertOne({@required T entity, Database database});
  Future<int> insertMany({@required List<T> entities, Database database});
  Future<int> updateOne({@required T entity, Database database});
  Future<int> updateMany({@required List<T> entities, Database database});
  Future<int> saveMany({@required List<T> entities, Database database});
  Future<int> saveOne({@required T entity, Database database});
  Future<int> deleteById({@required String id, Database database});
  Future<int> deleteByIds({List<String> ids, Database database});
  Future<int> deleteAll({Database database});
  Future<void> clear({Database database});
  Map<String, dynamic> sanitizeIncomingData(Map<String, dynamic> entity);
}

class Repository<T extends BaseEntity> extends BaseRepository<T> {
  @override
  Future<Database> get database => DatabaseManager.instance.database;

  @override
  Future<void> clear({Database database}) {
    final Database db = database != null ? database : this.database;
    // return
  }

  @override
  Future<List<T>> findAll(
      {List<QueryFilter> filters,
      List<String> fields,
      Map<String, SortOrder> sortOrder,
      Database database}) {
    final Database db = database != null ? database : this.database;
    return this.find(
        filters: filters, fields: fields, sortOrder: sortOrder, database: db);
  }

  @override
  Future<List<T>> find(
      {String id,
      List<QueryFilter> filters,
      List<String> fields,
      Map<String, SortOrder> sortOrder,
      Database database}) async {
    final Database db = database != null ? database : await this.database;

    if (id != null) {
      return (await db.query(this.entity.tableName,
              where: 'id = ?', whereArgs: [id], columns: fields))
          .map((e) {
        return getObject<T>(e);
      }).toList();
    }

    final String whereParameters = QueryFilter.getWhereParameters(filters);
    final String orderParameters =
        SortOrderUtil.getSortOrderParameters(sortOrder);

    if (whereParameters == null) {
      return (await db.query(this.entity.tableName,
              orderBy: orderParameters, columns: fields))
          .map((e) {
        return getObject<T>(e);
      }).toList();
    }

    return (await db.query(this.entity.tableName,
            where: whereParameters, orderBy: orderParameters, columns: fields))
        .map((e) {
      return getObject<T>(e);
    }).toList();
  }

  @override
  Future<T> findById(
      {@required String id, List<String> fields, Database database}) async {
    final Database db = database != null ? database : await this.database;

    var results = await this.find(id: id, fields: fields, database: db);

    return results.length > 0 ? results[0] : null;
  }

  @override
  Future<int> insertMany(
      {@required List<T> entities, Database database}) async {
    final Database db = database != null ? database : await this.database;

    await Future.forEach(
        entities, ((entity) => insertOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> insertOne({@required T entity, Database database}) async {
    Map<String, dynamic> data = this.sanitizeIncomingData(entity.toJson());
    final Database db = database != null ? database : await this.database;
    return db.insert(this.entity.tableName, data);
  }

  @override
  Future<int> deleteByIds({List<String> ids, Database database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName,
        where: 'id IN (?)', whereArgs: [ids.join(',')]);

    return 1;
  }

  @override
  Future<int> deleteById({@required String id, Database database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName, where: 'id = ?', whereArgs: [id]);

    return 1;
  }

  @override
  Future<int> deleteAll({Database database}) async {
    final Database db = database != null ? database : await this.database;

    await db.delete(this.entity.tableName);

    return 1;
  }

  @override
  Future<int> saveMany({@required List<T> entities, Database database}) async {
    final Database db = database != null ? database : await this.database;

    await Future.forEach(
        entities, ((entity) => saveOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> saveOne({@required T entity, Database database}) async {
    final Database db = database != null ? database : await this.database;

    var result = await this.findById(id: entity.id, database: db);

    if (result != null) {
      return this.updateOne(entity: entity, database: db);
    }

    return this.insertOne(entity: entity, database: db);
  }

  @override
  Future<int> updateMany(
      {@required List<T> entities, Database database}) async {
    final Database db = database != null ? database : await this.database;

    await Future.forEach(
        entities, ((entity) => updateOne(entity: entity, database: db)));

    return 1;
  }

  @override
  Future<int> updateOne({@required T entity, Database database}) async {
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
  List<Column> get columns =>
      Entity.getEntityColumns(AnnotationReflectable.reflectType(T));

  @override
  String get createQuery => QueryExpression.getCreateTableExpression(
      this.entity.tableName, this.columns);

  @override
  Future create({Database database}) async {
    final Database db = database != null ? database : await this.database;
    return db.execute(this.createQuery);
  }

  @override
  Entity get entity {
    return Entity.getEntityDefinition(AnnotationReflectable.reflectType(T));
  }

  @override
  Map<String, dynamic> sanitizeIncomingData(Map<String, dynamic> entity) {
    Map<String, dynamic> data = new Map();
    for (String key in entity.keys) {
      if (entity[key] is bool) {
        data[key] = entity[key] == true ? 1 : 0;
      } else {
        data[key] = entity[key];
      }
    }

    return data;
  }

  T getObject<T>(Map<String, dynamic> objectMap) {
    Map<String, dynamic> resultMap = {};
    this.columns.forEach((column) {
      var value = objectMap[column.name];

      if (value.runtimeType == int && column.type == ColumnType.BOOLEAN) {
        resultMap[column.name] = value == 1 ? true : false;
      } else {
        resultMap[column.name] = value;
      }
    });
    ClassMirror classMirror = AnnotationReflectable.reflectType(T);
    return classMirror.newInstance('fromJson', [resultMap]);
  }
}

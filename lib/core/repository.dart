import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'annotations/reflectable.annotation.dart';
import 'query_expression.dart';

abstract class BaseRepository<T> {
  List<Column> get columns;
  Entity get entity;
  String get createQuery;
  Future<Database> get database;
  Future<dynamic> create({Database database});
  Future<List<Map<String, dynamic>>> find({String id, Database database});
  Future<Map<String, dynamic>> findById(
      {@required String id, Database database});
  Future<List<Map<String, dynamic>>> findAll();
  Future<List<T>> findByIds(List<String> ids);
  Future<int> insertOne(
      {@required Map<String, dynamic> entity, Database database});
  Future<T> insertMany(List<T> entity);
  Future<int> updateOne(
      {@required Map<String, dynamic> entity, Database database});
  Future<T> updateMany(List<T> entity);
  Future<T> saveMany(List<T> entities);
  Future<int> saveOne(
      {@required Map<String, dynamic> entity, Database database});
  Future<int> deleteById({@required String id, Database database});
  Future<T> deleteByIds(List<String> ids);
  Future<T> deleteAll(List<String> ids);
  Future<void> clear();
  Map<String, dynamic> sanitizeIncomingData(Map<String, dynamic> entity);
}

class Repository<T> extends BaseRepository<T> {
  @override
  Future<Database> get database => DatabaseManager.instance.database;

  @override
  Future<void> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<List<T>> findByIds(List<String> ids) {
    // TODO: implement findByIds
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> findAll({Database database}) {
    final Database db = database != null ? database : this.database;
    return db.query(this.entity.tableName);
  }

  @override
  Future<List<Map<String, dynamic>>> find({String id, Database database}) {
    final Database db = database != null ? database : this.database;

    if (id != null) {
      return db.query(this.entity.tableName, where: 'id = ?', whereArgs: [id]);
    }

    return db.query(this.entity.tableName);
  }

  @override
  Future<Map<String, dynamic>> findById(
      {@required String id, Database database}) async {
    final Database db = database != null ? database : this.database;

    var results =
        await db.query(this.entity.tableName, where: 'id = ?', whereArgs: [id]);

    return results.length > 0 ? results[0] : null;
  }

  @override
  Future<T> insertMany(List<T> entity) {
    // TODO: implement insertMany
    throw UnimplementedError();
  }

  @override
  Future<int> insertOne(
      {@required Map<String, dynamic> entity, Database database}) {
    Map<String, dynamic> data = this.sanitizeIncomingData(entity);
    final Database db = database != null ? database : this.database;
    return db.insert(this.entity.tableName, data);
  }

  @override
  Future<T> deleteByIds(List<String> ids) {
    // TODO: implement removeMany
    throw UnimplementedError();
  }

  @override
  Future<int> deleteById({@required String id, Database database}) async {
    final Database db = database != null ? database : this.database;

    await db.delete(this.entity.tableName, where: 'id = ?', whereArgs: [id]);

    return 1;
  }

  @override
  Future<T> saveMany(List<T> entities) {
    // TODO: implement saveMany
    throw UnimplementedError();
  }

  @override
  Future<int> saveOne(
      {@required Map<String, dynamic> entity, Database database}) async {
    final Database db = database != null ? database : this.database;

    var result = await this.findById(id: entity['id'], database: db);

    if (result != null) {
      return this.updateOne(entity: entity, database: db);
    }

    return this.insertOne(entity: entity, database: db);
  }

  @override
  Future<T> updateMany(List<T> entity) {
    // TODO: implement updateMany
    throw UnimplementedError();
  }

  @override
  Future<int> updateOne(
      {@required Map<String, dynamic> entity, Database database}) {
    Map<String, dynamic> data = this.sanitizeIncomingData(entity);
    final Database db = database != null ? database : this.database;
    return db.update(
      this.entity.tableName,
      data,
      where: "id = ?",
      whereArgs: [data['id']],
    );
  }

  @override
  Future<T> deleteAll(List<String> ids) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  List<Column> get columns =>
      Entity.getEntityColumns(AnnotationReflectable.reflectType(T));

  @override
  String get createQuery => QueryExpression.getCreateTableExpression(
      this.entity.tableName, this.columns);

  @override
  Future create({Database database}) {
    final Database db = database != null ? database : this.database;
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
}

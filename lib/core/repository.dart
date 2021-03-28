import 'package:dhis2_flutter_sdk/core/annotations/index.dart';

import 'annotations/reflectable.annotation.dart';

abstract class BaseRepository<T> {
  List<dynamic> get columns;
  Future<T> findOne();
  Future<T> findById(String id);
  Future<List<T>> findAll();
  Future<List<T>> findByIds(List<String> ids);
  Future<T> insertOne(T entity);
  Future<T> insertMany(List<T> entity);
  Future<T> updateOne(T entity);
  Future<T> updateMany(List<T> entity);
  Future<T> saveMany(List<T> entities);
  Future<T> saveOne(T entity);
  Future<T> deleteById(String id);
  Future<T> deleteByIds(List<String> ids);
  Future<T> deleteAll(List<String> ids);
  Future<void> clear();
}

class Repository<T> extends BaseRepository<T> {
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
  Future<List<T>> findAll() {
    // TODO: implement findMany
    throw UnimplementedError();
  }

  @override
  Future<T> findOne() {
    // TODO: implement findOne
    throw UnimplementedError();
  }

  @override
  Future<T> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<T> insertMany(List<T> entity) {
    // TODO: implement insertMany
    throw UnimplementedError();
  }

  @override
  Future<T> insertOne(T entity) {
    // TODO: implement insertOne
    throw UnimplementedError();
  }

  @override
  Future<T> deleteByIds(List<String> ids) {
    // TODO: implement removeMany
    throw UnimplementedError();
  }

  @override
  Future<T> deleteById(String id) {
    // TODO: implement removeOne
    throw UnimplementedError();
  }

  @override
  Future<T> saveMany(List<T> entities) {
    // TODO: implement saveMany
    throw UnimplementedError();
  }

  @override
  Future<T> saveOne(T entity) {
    // TODO: implement saveOne
    throw UnimplementedError();
  }

  @override
  Future<T> updateMany(List<T> entity) {
    // TODO: implement updateMany
    throw UnimplementedError();
  }

  @override
  Future<T> updateOne(T entity) {
    // TODO: implement updateOne
    throw UnimplementedError();
  }

  @override
  Future<T> deleteAll(List<String> ids) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  // TODO: implement columns
  List get columns => throw UnimplementedError();

  @override
  List<Column> getTableColumns({Type type}) {
    return Entity.getEntityColumns(AnnotationReflectable.reflectType(T));
  }
}

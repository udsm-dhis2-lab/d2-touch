import 'package:isar/isar.dart';

/// Abstract base class for all Isar query operations
/// 
/// Provides common CRUD operations and query functionality
/// for all DHIS2 entities using Isar database
abstract class BaseIsarQuery<T> {
  final Future<Isar> isar;

  BaseIsarQuery({required this.isar});

  /// Get the Isar collection for this entity type
  IsarCollection<T> get collection;

  /// Get entity by ID
  Future<T?> byId(String id) async {
    final db = await isar;
    return await db.txn(() async {
      return await collection.where().filter().idEqualTo(id).findFirst();
    });
  }

  /// Get all entities
  Future<List<T>> all() async {
    final db = await isar;
    return await db.txn(() async {
      return await collection.where().findAll();
    });
  }

  /// Save single entity
  Future<T> save(T entity) async {
    final db = await isar;
    return await db.writeTxn(() async {
      await collection.put(entity);
      return entity;
    });
  }

  /// Save multiple entities
  Future<List<T>> saveAll(List<T> entities) async {
    final db = await isar;
    return await db.writeTxn(() async {
      await collection.putAll(entities);
      return entities;
    });
  }

  /// Delete entity by ID
  Future<bool> deleteById(String id) async {
    final db = await isar;
    return await db.writeTxn(() async {
      final entity = await collection.where().filter().idEqualTo(id).findFirst();
      if (entity != null) {
        await collection.delete(entity as int);
        return true;
      }
      return false;
    });
  }

  /// Delete multiple entities by IDs
  Future<int> deleteByIds(List<String> ids) async {
    final db = await isar;
    return await db.writeTxn(() async {
      int deletedCount = 0;
      for (final id in ids) {
        final entity = await collection.where().filter().idEqualTo(id).findFirst();
        if (entity != null) {
          await collection.delete(entity as int);
          deletedCount++;
        }
      }
      return deletedCount;
    });
  }

  /// Count all entities
  Future<int> count() async {
    final db = await isar;
    return await db.txn(() async {
      return await collection.count();
    });
  }

  /// Watch all entities for changes (reactive stream)
  Stream<List<T>> watch({bool fireImmediately = true}) async* {
    final db = await isar;
    yield* collection.where().watch(fireImmediately: fireImmediately);
  }

  /// Watch entity by ID for changes
  Stream<T?> watchById(String id, {bool fireImmediately = true}) async* {
    final db = await isar;
    yield* collection.where().filter().idEqualTo(id).watch(fireImmediately: fireImmediately)
        .map((entities) => entities.isNotEmpty ? entities.first : null);
  }

  /// Clear all entities
  Future<void> clear() async {
    final db = await isar;
    await db.writeTxn(() async {
      await collection.clear();
    });
  }
}

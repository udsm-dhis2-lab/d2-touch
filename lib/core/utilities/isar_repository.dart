import 'package:isar/isar.dart';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:d2_touch/shared/utilities/save_option.util.dart';
import 'package:d2_touch/shared/utilities/sort_order.util.dart';

/// Generic Isar Repository
/// 
/// Replaces the SQLite-based Repository with Isar implementation
/// Provides CRUD operations and query capabilities for DHIS2 entities
class IsarRepository<T extends BaseIsarEntity> {
  final IsarManager isarManager;
  final IsarCollection<T> collection;

  IsarRepository({
    required this.isarManager,
    required this.collection,
  });

  /// Create/initialize the collection (equivalent to create table)
  Future<void> create() async {
    // Isar collections are created automatically when the database is opened
    // This method exists for compatibility with the existing API
    await isarManager.database;
  }

  /// Save a single entity
  /// 
  /// Returns the ID of the saved entity
  Future<Id> saveOne({
    required T entity,
    MergeMode mergeMode = MergeMode.Replace,
    SaveOptions? saveOptions,
  }) async {
    return await isarManager.writeTxn((isar) async {
      // Update timestamp
      entity.updateTimestamp();
      
      // Handle merge mode
      if (mergeMode == MergeMode.Merge) {
        final existing = await collection.filter()
            .dhis2IdEqualTo(entity.dhis2Id)
            .findFirst();
            
        if (existing != null) {
          // Merge logic - preserve server data unless explicitly overriding
          entity.id = existing.id;
          if (!entity.dirty && existing.dirty) {
            entity.dirty = existing.dirty;
          }
          if (entity.serverCreated == null && existing.serverCreated != null) {
            entity.serverCreated = existing.serverCreated;
          }
          if (entity.serverLastUpdated == null && existing.serverLastUpdated != null) {
            entity.serverLastUpdated = existing.serverLastUpdated;
          }
        }
      }
      
      return await collection.put(entity);
    });
  }

  /// Save multiple entities
  /// 
  /// Returns the number of entities saved
  Future<int> saveMany({
    required List<T> entities,
    MergeMode mergeMode = MergeMode.Replace,
    SaveOptions? saveOptions,
  }) async {
    if (entities.isEmpty) return 0;
    
    return await isarManager.writeTxn((isar) async {
      // Update timestamps for all entities
      for (final entity in entities) {
        entity.updateTimestamp();
      }
      
      if (mergeMode == MergeMode.Merge) {
        // Handle merge mode for batch operations
        final dhis2Ids = entities.map((e) => e.dhis2Id).toList();
        final existing = await collection.filter()
            .anyOf(dhis2Ids, (q, dhis2Id) => q.dhis2IdEqualTo(dhis2Id))
            .findAll();
            
        final existingMap = {for (var e in existing) e.dhis2Id: e};
        
        for (final entity in entities) {
          final existingEntity = existingMap[entity.dhis2Id];
          if (existingEntity != null) {
            entity.id = existingEntity.id;
            if (!entity.dirty && existingEntity.dirty) {
              entity.dirty = existingEntity.dirty;
            }
            if (entity.serverCreated == null && existingEntity.serverCreated != null) {
              entity.serverCreated = existingEntity.serverCreated;
            }
            if (entity.serverLastUpdated == null && existingEntity.serverLastUpdated != null) {
              entity.serverLastUpdated = existingEntity.serverLastUpdated;
            }
          }
        }
      }
      
      await collection.putAll(entities);
      return entities.length;
    });
  }

  /// Find entity by ID
  Future<T?> findById(String dhis2Id) async {
    return await isarManager.readTxn((isar) async {
      return await collection.filter()
          .dhis2IdEqualTo(dhis2Id)
          .findFirst();
    });
  }

  /// Find entity by Isar ID
  Future<T?> findByIsarId(Id id) async {
    return await isarManager.readTxn((isar) async {
      return await collection.get(id);
    });
  }

  /// Find all entities
  Future<List<T>> findAll({
    List<String>? fields, // Not used in Isar - all fields are always loaded
    Map<String, SortOrder>? sortOrder,
    int? limit,
    int? offset,
  }) async {
    return await isarManager.readTxn((isar) async {
      var query = collection.where();
      
      // Apply sorting
      if (sortOrder != null && sortOrder.isNotEmpty) {
        final entry = sortOrder.entries.first;
        switch (entry.key.toLowerCase()) {
          case 'name':
            query = entry.value == SortOrder.ASC 
                ? query.sortByName() 
                : query.sortByNameDesc();
            break;
          case 'created':
          case 'createdtimestamp':
            query = entry.value == SortOrder.ASC 
                ? query.sortByCreatedTimestamp() 
                : query.sortByCreatedTimestampDesc();
            break;
          case 'lastupdated':
          case 'lastupdatedtimestamp':
            query = entry.value == SortOrder.ASC 
                ? query.sortByLastUpdatedTimestamp() 
                : query.sortByLastUpdatedTimestampDesc();
            break;
          default:
            // Default sort by name
            query = query.sortByName();
        }
      } else {
        // Default sort by name
        query = query.sortByName();
      }
      
      // Apply pagination
      if (offset != null) {
        query = query.offset(offset);
      }
      
      if (limit != null) {
        query = query.limit(limit);
      }
      
      return await query.findAll();
    });
  }

  /// Find entities with custom filter
  Future<List<T>> findWhere({
    required bool Function(QueryBuilder<T, T, QWhere>) filter,
    Map<String, SortOrder>? sortOrder,
    int? limit,
    int? offset,
  }) async {
    return await isarManager.readTxn((isar) async {
      var query = collection.where();
      
      // Apply filter
      query = filter(query) as Query<T>;
      
      // Apply sorting
      if (sortOrder != null && sortOrder.isNotEmpty) {
        // Note: Sorting after where clause requires different approach in Isar
        // This is a simplified implementation
        final results = await query.findAll();
        final entry = sortOrder.entries.first;
        
        results.sort((a, b) {
          int comparison = 0;
          switch (entry.key.toLowerCase()) {
            case 'name':
              if (a is IdentifiableIsarEntity && b is IdentifiableIsarEntity) {
                comparison = a.name.compareTo(b.name);
              }
              break;
            case 'created':
            case 'createdtimestamp':
              comparison = a.createdTimestamp.compareTo(b.createdTimestamp);
              break;
            case 'lastupdated':
            case 'lastupdatedtimestamp':
              comparison = a.lastUpdatedTimestamp.compareTo(b.lastUpdatedTimestamp);
              break;
          }
          
          return entry.value == SortOrder.ASC ? comparison : -comparison;
        });
        
        // Apply pagination to sorted results
        int start = offset ?? 0;
        int end = limit != null ? start + limit : results.length;
        end = end > results.length ? results.length : end;
        
        return results.sublist(start, end);
      }
      
      // Apply pagination
      if (offset != null) {
        query = query.offset(offset);
      }
      
      if (limit != null) {
        query = query.limit(limit);
      }
      
      return await query.findAll();
    });
  }

  /// Find entities by multiple IDs
  Future<List<T>> findByIds(List<String> dhis2Ids) async {
    if (dhis2Ids.isEmpty) return [];
    
    return await isarManager.readTxn((isar) async {
      return await collection.filter()
          .anyOf(dhis2Ids, (q, dhis2Id) => q.dhis2IdEqualTo(dhis2Id))
          .findAll();
    });
  }

  /// Find dirty entities (not synced)
  Future<List<T>> findDirty() async {
    return await isarManager.readTxn((isar) async {
      return await collection.filter()
          .dirtyEqualTo(true)
          .findAll();
    });
  }

  /// Find synced entities
  Future<List<T>> findSynced() async {
    return await isarManager.readTxn((isar) async {
      return await collection.filter()
          .syncedEqualTo(true)
          .findAll();
    });
  }

  /// Count all entities
  Future<int> count() async {
    return await isarManager.readTxn((isar) async {
      return await collection.count();
    });
  }

  /// Count entities with filter
  Future<int> countWhere({
    required bool Function(QueryBuilder<T, T, QWhere>) filter,
  }) async {
    return await isarManager.readTxn((isar) async {
      var query = collection.where();
      query = filter(query) as Query<T>;
      return await query.count();
    });
  }

  /// Delete entity by ID
  Future<bool> deleteById(String dhis2Id) async {
    return await isarManager.writeTxn((isar) async {
      final entity = await collection.filter()
          .dhis2IdEqualTo(dhis2Id)
          .findFirst();
          
      if (entity?.id != null) {
        return await collection.delete(entity!.id!);
      }
      return false;
    });
  }

  /// Delete entity by Isar ID
  Future<bool> deleteByIsarId(Id id) async {
    return await isarManager.writeTxn((isar) async {
      return await collection.delete(id);
    });
  }

  /// Delete multiple entities by IDs
  Future<int> deleteByIds(List<String> dhis2Ids) async {
    if (dhis2Ids.isEmpty) return 0;
    
    return await isarManager.writeTxn((isar) async {
      final entities = await collection.filter()
          .anyOf(dhis2Ids, (q, dhis2Id) => q.dhis2IdEqualTo(dhis2Id))
          .findAll();
          
      final ids = entities.map((e) => e.id!).toList();
      return await collection.deleteAll(ids);
    });
  }

  /// Delete all entities
  Future<int> deleteAll() async {
    return await isarManager.writeTxn((isar) async {
      return await collection.clear();
    });
  }

  /// Watch entities (reactive)
  /// 
  /// Returns a stream that emits when entities change
  Stream<List<T>> watchAll({
    bool fireImmediately = true,
    Map<String, SortOrder>? sortOrder,
  }) {
    var query = collection.where();
    
    // Apply sorting
    if (sortOrder != null && sortOrder.isNotEmpty) {
      final entry = sortOrder.entries.first;
      switch (entry.key.toLowerCase()) {
        case 'name':
          query = entry.value == SortOrder.ASC 
              ? query.sortByName() 
              : query.sortByNameDesc();
          break;
        case 'created':
        case 'createdtimestamp':
          query = entry.value == SortOrder.ASC 
              ? query.sortByCreatedTimestamp() 
              : query.sortByCreatedTimestampDesc();
          break;
        case 'lastupdated':
        case 'lastupdatedtimestamp':
          query = entry.value == SortOrder.ASC 
              ? query.sortByLastUpdatedTimestamp() 
              : query.sortByLastUpdatedTimestampDesc();
          break;
        default:
          query = query.sortByName();
      }
    } else {
      query = query.sortByName();
    }
    
    return query.watch(fireImmediately: fireImmediately);
  }

  /// Watch entity by ID
  Stream<T?> watchById(String dhis2Id, {bool fireImmediately = true}) {
    return collection.filter()
        .dhis2IdEqualTo(dhis2Id)
        .watch(fireImmediately: fireImmediately)
        .map((entities) => entities.isNotEmpty ? entities.first : null);
  }

  /// Watch dirty entities
  Stream<List<T>> watchDirty({bool fireImmediately = true}) {
    return collection.filter()
        .dirtyEqualTo(true)
        .watch(fireImmediately: fireImmediately);
  }

  /// Bulk mark entities as synced
  Future<int> markAsSynced(List<String> dhis2Ids) async {
    if (dhis2Ids.isEmpty) return 0;
    
    return await isarManager.writeTxn((isar) async {
      final entities = await collection.filter()
          .anyOf(dhis2Ids, (q, dhis2Id) => q.dhis2IdEqualTo(dhis2Id))
          .findAll();
      
      for (final entity in entities) {
        entity.markSynced();
      }
      
      await collection.putAll(entities);
      return entities.length;
    });
  }

  /// Bulk mark entities as dirty
  Future<int> markAsDirty(List<String> dhis2Ids) async {
    if (dhis2Ids.isEmpty) return 0;
    
    return await isarManager.writeTxn((isar) async {
      final entities = await collection.filter()
          .anyOf(dhis2Ids, (q, dhis2Id) => q.dhis2IdEqualTo(dhis2Id))
          .findAll();
      
      for (final entity in entities) {
        entity.markDirty();
      }
      
      await collection.putAll(entities);
      return entities.length;
    });
  }

  /// Get collection statistics
  Future<Map<String, dynamic>> getStats() async {
    return await isarManager.readTxn((isar) async {
      final total = await collection.count();
      final dirty = await collection.filter().dirtyEqualTo(true).count();
      final synced = await collection.filter().syncedEqualTo(true).count();
      
      return {
        'collection': collection.name,
        'total': total,
        'dirty': dirty,
        'synced': synced,
        'clean': total - dirty,
      };
    });
  }
}

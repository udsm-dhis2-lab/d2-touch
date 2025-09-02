import 'package:d2_touch/core/utilities/query/base_isar.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_isar.entity.dart';
import 'package:isar/isar.dart';

/// TrackedEntity Isar Query
/// 
/// Handles queries for TrackedEntityIsar collection
/// Optimized for tracker search, enrollment, and sync operations
class TrackedEntityIsarQuery extends BaseIsarQuery<TrackedEntityIsar> {
  TrackedEntityIsarQuery({required super.isar});

  @override
  IsarCollection<TrackedEntityIsar> get collection => isar.trackedEntityIsars;

  /// Get tracked entities by organisation unit
  Future<List<TrackedEntityIsar>> byOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get tracked entities by tracked entity type
  Future<List<TrackedEntityIsar>> byTrackedEntityType(String trackedEntityTypeId) async {
    return await collection
        .where()
        .trackedEntityTypeEqualTo(trackedEntityTypeId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get tracked entities by program
  Future<List<TrackedEntityIsar>> byProgram(String programId) async {
    final enrollments = await isar.enrollmentIsars
        .where()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .findAll();

    final teiIds = enrollments.map((e) => e.trackedEntityInstance).where((id) => id != null).cast<String>().toSet();
    
    if (teiIds.isEmpty) return [];
    
    final queries = <QueryBuilder<TrackedEntityIsar, TrackedEntityIsar, QWhere>>[];
    
    for (final teiId in teiIds) {
      queries.add(collection.where().dhis2IdEqualTo(teiId));
    }
    
    final results = <TrackedEntityIsar>[];
    for (final query in queries) {
      final entities = await query.findAll();
      results.addAll(entities);
    }
    
    return results;
  }

  /// Search tracked entities by attribute value
  Future<List<TrackedEntityIsar>> searchByAttribute(String attributeId, String value) async {
    final all = await collection
        .where()
        .not()
        .deletedEqualTo(true)
        .findAll();

    return all.where((tei) {
      final attributes = tei.attributes;
      for (final attr in attributes) {
        if (attr['attribute'] == attributeId) {
          final attrValue = attr['value']?.toString().toLowerCase() ?? '';
          return attrValue.contains(value.toLowerCase());
        }
      }
      return false;
    }).toList();
  }

  /// Search tracked entities by multiple attributes
  Future<List<TrackedEntityIsar>> searchByAttributes(Map<String, String> attributeValues) async {
    if (attributeValues.isEmpty) return [];
    
    final all = await collection
        .where()
        .not()
        .deletedEqualTo(true)
        .findAll();

    return all.where((tei) {
      final attributes = tei.attributes;
      bool matches = true;
      
      for (final searchAttr in attributeValues.entries) {
        bool found = false;
        for (final attr in attributes) {
          if (attr['attribute'] == searchAttr.key) {
            final attrValue = attr['value']?.toString().toLowerCase() ?? '';
            if (attrValue.contains(searchAttr.value.toLowerCase())) {
              found = true;
              break;
            }
          }
        }
        if (!found) {
          matches = false;
          break;
        }
      }
      
      return matches;
    }).toList();
  }

  /// Get tracked entities needing sync
  Future<List<TrackedEntityIsar>> getNeedingSync() async {
    return await collection
        .where()
        .dirtyEqualTo(true)
        .or()
        .syncedEqualTo(false)
        .findAll();
  }

  /// Get tracked entities with sync failures
  Future<List<TrackedEntityIsar>> getSyncFailed() async {
    return await collection
        .where()
        .syncFailedEqualTo(true)
        .sortByLastSyncTimestamp()
        .findAll();
  }

  /// Get tracked entities by sync status
  Future<List<TrackedEntityIsar>> bySyncStatus({
    bool? synced,
    bool? dirty,
    bool? syncFailed,
  }) async {
    var query = collection.where();
    
    if (synced != null) {
      query = query.syncedEqualTo(synced);
    }
    
    if (dirty != null) {
      if (synced != null) {
        query = query.and();
      }
      query = query.dirtyEqualTo(dirty);
    }
    
    if (syncFailed != null) {
      if (synced != null || dirty != null) {
        query = query.and();
      }
      query = query.syncFailedEqualTo(syncFailed);
    }
    
    return await query.findAll();
  }

  /// Get tracked entities created after specific date
  Future<List<TrackedEntityIsar>> createdAfter(DateTime date) async {
    return await collection
        .where()
        .createdTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByCreatedTimestamp()
        .findAll();
  }

  /// Get tracked entities updated after specific date
  Future<List<TrackedEntityIsar>> updatedAfter(DateTime date) async {
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get tracked entities by geometry/coordinate presence
  Future<List<TrackedEntityIsar>> withCoordinates() async {
    return await collection
        .where()
        .geometryIsNotNull()
        .findAll();
  }

  /// Get tracked entities for enrollment in program
  Future<List<TrackedEntityIsar>> availableForEnrollment(
    String programId,
    String orgUnitId, {
    String? trackedEntityTypeId,
  }) async {
    var query = collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true);

    if (trackedEntityTypeId != null) {
      query = query.and().trackedEntityTypeEqualTo(trackedEntityTypeId);
    }

    final entities = await query.findAll();

    // Filter out those already enrolled in the program
    final enrolled = await isar.enrollmentIsars
        .where()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .findAll();

    final enrolledTeiIds = enrolled
        .map((e) => e.trackedEntityInstance)
        .where((id) => id != null)
        .toSet();

    return entities
        .where((tei) => !enrolledTeiIds.contains(tei.dhis2Id))
        .toList();
  }

  /// Get tracked entities with recent activity
  Future<List<TrackedEntityIsar>> withRecentActivity({
    int daysBack = 30,
  }) async {
    final cutoff = DateTime.now().subtract(Duration(days: daysBack));
    
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(cutoff.millisecondsSinceEpoch)
        .or()
        .lastSyncTimestampGreaterThan(cutoff.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestampDesc()
        .findAll();
  }

  /// Count tracked entities by organisation unit
  Future<int> countByOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count tracked entities by tracked entity type
  Future<int> countByTrackedEntityType(String trackedEntityTypeId) async {
    return await collection
        .where()
        .trackedEntityTypeEqualTo(trackedEntityTypeId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Get tracked entities with pending relationships
  Future<List<TrackedEntityIsar>> withPendingRelationships() async {
    final all = await collection
        .where()
        .not()
        .deletedEqualTo(true)
        .findAll();

    return all.where((tei) {
      final relationships = tei.relationships;
      return relationships.any((rel) => rel['pending'] == true);
    }).toList();
  }

  /// Bulk update sync status
  Future<void> bulkUpdateSyncStatus({
    required List<String> dhis2Ids,
    bool? synced,
    bool? dirty,
    bool? syncFailed,
  }) async {
    await isar.writeTxn(() async {
      for (final dhis2Id in dhis2Ids) {
        final entity = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
        if (entity != null) {
          if (synced != null) entity.synced = synced;
          if (dirty != null) entity.dirty = dirty;
          if (syncFailed != null) entity.syncFailed = syncFailed;
          
          entity.lastUpdatedTimestamp = DateTime.now().millisecondsSinceEpoch;
          await collection.put(entity);
        }
      }
    });
  }

  /// Delete tracked entities and related data
  Future<void> deleteWithRelatedData(List<String> dhis2Ids) async {
    await isar.writeTxn(() async {
      for (final dhis2Id in dhis2Ids) {
        // Delete enrollments
        final enrollments = await isar.enrollmentIsars
            .where()
            .trackedEntityInstanceEqualTo(dhis2Id)
            .findAll();
        
        for (final enrollment in enrollments) {
          // Delete events for each enrollment
          final events = await isar.eventIsars
              .where()
              .enrollmentEqualTo(enrollment.dhis2Id)
              .findAll();
          
          await isar.eventIsars.deleteAll(events.map((e) => e.id).toList());
          
          // Delete enrollment
          await isar.enrollmentIsars.delete(enrollment.id);
        }
        
        // Delete tracked entity
        final entity = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
        if (entity != null) {
          await collection.delete(entity.id);
        }
      }
    });
  }
}

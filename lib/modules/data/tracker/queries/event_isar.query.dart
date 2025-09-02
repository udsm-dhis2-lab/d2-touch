import 'package:d2_touch/core/utilities/query/base_isar.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_isar.entity.dart';
import 'package:isar/isar.dart';

/// Event Isar Query
/// 
/// Handles queries for EventIsar collection
/// Optimized for data entry, completion, and sync operations
class EventIsarQuery extends BaseIsarQuery<EventIsar> {
  EventIsarQuery({required super.isar});

  @override
  IsarCollection<EventIsar> get collection => isar.eventIsars;

  /// Get events by organisation unit
  Future<List<EventIsar>> byOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .findAll();
  }

  /// Get events by program stage
  Future<List<EventIsar>> byProgramStage(String programStageId) async {
    return await collection
        .where()
        .programStageEqualTo(programStageId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .findAll();
  }

  /// Get events by tracked entity instance
  Future<List<EventIsar>> byTrackedEntityInstance(String teiId) async {
    return await collection
        .where()
        .trackedEntityInstanceEqualTo(teiId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .findAll();
  }

  /// Get events by enrollment
  Future<List<EventIsar>> byEnrollment(String enrollmentId) async {
    return await collection
        .where()
        .enrollmentEqualTo(enrollmentId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .findAll();
  }

  /// Get events by status
  Future<List<EventIsar>> byStatus(String status) async {
    return await collection
        .where()
        .statusEqualTo(status)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .findAll();
  }

  /// Get active events
  Future<List<EventIsar>> getActive() async {
    return await byStatus('ACTIVE');
  }

  /// Get completed events
  Future<List<EventIsar>> getCompleted() async {
    return await byStatus('COMPLETED');
  }

  /// Get scheduled events
  Future<List<EventIsar>> getScheduled() async {
    return await byStatus('SCHEDULE');
  }

  /// Get overdue events
  Future<List<EventIsar>> getOverdue() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return await collection
        .where()
        .dueDateTimestampLessThan(now)
        .and()
        .not()
        .statusEqualTo('COMPLETED')
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByDueDateTimestamp()
        .findAll();
  }

  /// Get events for date range
  Future<List<EventIsar>> byDateRange(DateTime startDate, DateTime endDate) async {
    return await collection
        .where()
        .eventDateTimestampBetween(
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        )
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestamp()
        .findAll();
  }

  /// Get events due in date range
  Future<List<EventIsar>> dueInDateRange(DateTime startDate, DateTime endDate) async {
    return await collection
        .where()
        .dueDateTimestampBetween(
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        )
        .and()
        .not()
        .deletedEqualTo(true)
        .and()
        .not()
        .statusEqualTo('COMPLETED')
        .sortByDueDateTimestamp()
        .findAll();
  }

  /// Get events for today
  Future<List<EventIsar>> forToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return await byDateRange(startOfDay, endOfDay);
  }

  /// Get events due today
  Future<List<EventIsar>> dueToday() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return await dueInDateRange(startOfDay, endOfDay);
  }

  /// Get events needing sync
  Future<List<EventIsar>> getNeedingSync() async {
    return await collection
        .where()
        .dirtyEqualTo(true)
        .or()
        .syncedEqualTo(false)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get events with sync failures
  Future<List<EventIsar>> getSyncFailed() async {
    return await collection
        .where()
        .syncFailedEqualTo(true)
        .sortByLastSyncTimestamp()
        .findAll();
  }

  /// Search events by data value
  Future<List<EventIsar>> searchByDataValue(String dataElementId, String value) async {
    final all = await collection
        .where()
        .not()
        .deletedEqualTo(true)
        .findAll();

    return all.where((event) {
      final dataValue = event.getDataValue(dataElementId);
      if (dataValue != null) {
        return dataValue.toLowerCase().contains(value.toLowerCase());
      }
      return false;
    }).toList();
  }

  /// Get events with coordinates
  Future<List<EventIsar>> withCoordinates() async {
    return await collection
        .where()
        .coordinateIsNotNull()
        .and()
        .not()
        .deletedEqualTo(true)
        .findAll();
  }

  /// Get events by sync status
  Future<List<EventIsar>> bySyncStatus({
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

  /// Get events created after specific date
  Future<List<EventIsar>> createdAfter(DateTime date) async {
    return await collection
        .where()
        .createdTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByCreatedTimestamp()
        .findAll();
  }

  /// Get events updated after specific date
  Future<List<EventIsar>> updatedAfter(DateTime date) async {
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get upcoming events (due in next N days)
  Future<List<EventIsar>> getUpcoming({int days = 7}) async {
    final now = DateTime.now();
    final future = now.add(Duration(days: days));
    
    return await collection
        .where()
        .dueDateTimestampBetween(
          now.millisecondsSinceEpoch,
          future.millisecondsSinceEpoch,
        )
        .and()
        .not()
        .statusEqualTo('COMPLETED')
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByDueDateTimestamp()
        .findAll();
  }

  /// Get events with recent activity
  Future<List<EventIsar>> withRecentActivity({
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

  /// Count events by status
  Future<int> countByStatus(String status) async {
    return await collection
        .where()
        .statusEqualTo(status)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count overdue events
  Future<int> countOverdue() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    return await collection
        .where()
        .dueDateTimestampLessThan(now)
        .and()
        .not()
        .statusEqualTo('COMPLETED')
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count events by organisation unit
  Future<int> countByOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count events by program stage
  Future<int> countByProgramStage(String programStageId) async {
    return await collection
        .where()
        .programStageEqualTo(programStageId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Get events by enrollment with pagination
  Future<List<EventIsar>> byEnrollmentPaginated(
    String enrollmentId, {
    int offset = 0,
    int limit = 50,
  }) async {
    return await collection
        .where()
        .enrollmentEqualTo(enrollmentId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEventDateTimestampDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
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

  /// Mark events as completed
  Future<void> bulkMarkCompleted(List<String> dhis2Ids) async {
    await isar.writeTxn(() async {
      for (final dhis2Id in dhis2Ids) {
        final entity = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
        if (entity != null) {
          entity.markCompleted();
          await collection.put(entity);
        }
      }
    });
  }

  /// Delete events by enrollment
  Future<void> deleteByEnrollment(String enrollmentId) async {
    await isar.writeTxn(() async {
      final events = await collection
          .where()
          .enrollmentEqualTo(enrollmentId)
          .findAll();
      
      await collection.deleteAll(events.map((e) => e.id).toList());
    });
  }

  /// Get completion statistics by program stage
  Future<Map<String, dynamic>> getCompletionStats(String programStageId) async {
    final total = await countByProgramStage(programStageId);
    final completed = await collection
        .where()
        .programStageEqualTo(programStageId)
        .and()
        .statusEqualTo('COMPLETED')
        .and()
        .not()
        .deletedEqualTo(true)
        .count();

    return {
      'total': total,
      'completed': completed,
      'pending': total - completed,
      'completionRate': total > 0 ? (completed / total * 100).round() : 0,
    };
  }
}

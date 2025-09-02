import 'package:d2_touch/core/utilities/query/base_isar.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment_isar.entity.dart';
import 'package:isar/isar.dart';

/// Enrollment Isar Query
/// 
/// Handles queries for EnrollmentIsar collection
/// Optimized for program enrollment and tracker operations
class EnrollmentIsarQuery extends BaseIsarQuery<EnrollmentIsar> {
  EnrollmentIsarQuery({required super.isar});

  @override
  IsarCollection<EnrollmentIsar> get collection => isar.enrollmentIsars;

  /// Get enrollments by program
  Future<List<EnrollmentIsar>> byProgram(String programId) async {
    return await collection
        .where()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Get enrollments by tracked entity instance
  Future<List<EnrollmentIsar>> byTrackedEntityInstance(String teiId) async {
    return await collection
        .where()
        .trackedEntityInstanceEqualTo(teiId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Get enrollments by organisation unit
  Future<List<EnrollmentIsar>> byOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Get enrollments by status
  Future<List<EnrollmentIsar>> byStatus(String status) async {
    return await collection
        .where()
        .statusEqualTo(status)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Get active enrollments
  Future<List<EnrollmentIsar>> getActive() async {
    return await byStatus('ACTIVE');
  }

  /// Get completed enrollments
  Future<List<EnrollmentIsar>> getCompleted() async {
    return await byStatus('COMPLETED');
  }

  /// Get cancelled enrollments
  Future<List<EnrollmentIsar>> getCancelled() async {
    return await byStatus('CANCELLED');
  }

  /// Get enrollments with follow up
  Future<List<EnrollmentIsar>> getFollowUp() async {
    return await collection
        .where()
        .followUpEqualTo(true)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Get enrollments for date range
  Future<List<EnrollmentIsar>> byDateRange(DateTime startDate, DateTime endDate) async {
    return await collection
        .where()
        .enrollmentDateTimestampBetween(
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        )
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestamp()
        .findAll();
  }

  /// Get enrollments by incident date range
  Future<List<EnrollmentIsar>> byIncidentDateRange(DateTime startDate, DateTime endDate) async {
    return await collection
        .where()
        .incidentDateTimestampBetween(
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        )
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByIncidentDateTimestamp()
        .findAll();
  }

  /// Get enrollments for program and orgunit
  Future<List<EnrollmentIsar>> byProgramAndOrgUnit(String programId, String orgUnitId) async {
    return await collection
        .where()
        .programEqualTo(programId)
        .and()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .findAll();
  }

  /// Check if tracked entity is enrolled in program
  Future<bool> isEnrolledInProgram(String teiId, String programId) async {
    final count = await collection
        .where()
        .trackedEntityInstanceEqualTo(teiId)
        .and()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .and()
        .not()
        .statusEqualTo('CANCELLED')
        .count();
    
    return count > 0;
  }

  /// Get active enrollment for tracked entity in program
  Future<EnrollmentIsar?> getActiveEnrollment(String teiId, String programId) async {
    return await collection
        .where()
        .trackedEntityInstanceEqualTo(teiId)
        .and()
        .programEqualTo(programId)
        .and()
        .statusEqualTo('ACTIVE')
        .and()
        .not()
        .deletedEqualTo(true)
        .findFirst();
  }

  /// Search enrollments by attribute value
  Future<List<EnrollmentIsar>> searchByAttribute(String attributeId, String value) async {
    final all = await collection
        .where()
        .not()
        .deletedEqualTo(true)
        .findAll();

    return all.where((enrollment) {
      final attrValue = enrollment.getAttributeValue(attributeId);
      if (attrValue != null) {
        return attrValue.toLowerCase().contains(value.toLowerCase());
      }
      return false;
    }).toList();
  }

  /// Get enrollments needing sync
  Future<List<EnrollmentIsar>> getNeedingSync() async {
    return await collection
        .where()
        .dirtyEqualTo(true)
        .or()
        .syncedEqualTo(false)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get enrollments with sync failures
  Future<List<EnrollmentIsar>> getSyncFailed() async {
    return await collection
        .where()
        .syncFailedEqualTo(true)
        .sortByLastSyncTimestamp()
        .findAll();
  }

  /// Get enrollments by sync status
  Future<List<EnrollmentIsar>> bySyncStatus({
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

  /// Get enrollments created after specific date
  Future<List<EnrollmentIsar>> createdAfter(DateTime date) async {
    return await collection
        .where()
        .createdTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByCreatedTimestamp()
        .findAll();
  }

  /// Get enrollments updated after specific date
  Future<List<EnrollmentIsar>> updatedAfter(DateTime date) async {
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get enrollments with coordinates
  Future<List<EnrollmentIsar>> withCoordinates() async {
    return await collection
        .where()
        .coordinateIsNotNull()
        .and()
        .not()
        .deletedEqualTo(true)
        .findAll();
  }

  /// Get enrollments with recent activity
  Future<List<EnrollmentIsar>> withRecentActivity({
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

  /// Count enrollments by program
  Future<int> countByProgram(String programId) async {
    return await collection
        .where()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count active enrollments by program
  Future<int> countActiveByProgram(String programId) async {
    return await collection
        .where()
        .programEqualTo(programId)
        .and()
        .statusEqualTo('ACTIVE')
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count enrollments by organisation unit
  Future<int> countByOrgUnit(String orgUnitId) async {
    return await collection
        .where()
        .orgUnitEqualTo(orgUnitId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Count enrollments by status
  Future<int> countByStatus(String status) async {
    return await collection
        .where()
        .statusEqualTo(status)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();
  }

  /// Get enrollments with pagination
  Future<List<EnrollmentIsar>> getPaginated({
    int offset = 0,
    int limit = 50,
    String? programId,
    String? orgUnitId,
    String? status,
  }) async {
    var query = collection.where();
    
    if (programId != null) {
      query = query.programEqualTo(programId);
    }
    
    if (orgUnitId != null) {
      if (programId != null) {
        query = query.and();
      }
      query = query.orgUnitEqualTo(orgUnitId);
    }
    
    if (status != null) {
      if (programId != null || orgUnitId != null) {
        query = query.and();
      }
      query = query.statusEqualTo(status);
    }
    
    return await query
        .and()
        .not()
        .deletedEqualTo(true)
        .sortByEnrollmentDateTimestampDesc()
        .offset(offset)
        .limit(limit)
        .findAll();
  }

  /// Get enrollment statistics
  Future<Map<String, dynamic>> getStatistics({
    String? programId,
    String? orgUnitId,
  }) async {
    var query = collection.where();
    
    if (programId != null) {
      query = query.programEqualTo(programId);
    }
    
    if (orgUnitId != null) {
      if (programId != null) {
        query = query.and();
      }
      query = query.orgUnitEqualTo(orgUnitId);
    }
    
    query = query.and().not().deletedEqualTo(true);
    
    final total = await query.count();
    final active = await query.and().statusEqualTo('ACTIVE').count();
    final completed = await query.and().statusEqualTo('COMPLETED').count();
    final cancelled = await query.and().statusEqualTo('CANCELLED').count();
    final followUp = await query.and().followUpEqualTo(true).count();
    
    return {
      'total': total,
      'active': active,
      'completed': completed,
      'cancelled': cancelled,
      'followUp': followUp,
      'completionRate': total > 0 ? (completed / total * 100).round() : 0,
    };
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

  /// Bulk update status
  Future<void> bulkUpdateStatus({
    required List<String> dhis2Ids,
    required String status,
    String? completedBy,
  }) async {
    await isar.writeTxn(() async {
      for (final dhis2Id in dhis2Ids) {
        final entity = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
        if (entity != null) {
          entity.status = status;
          if (status == 'COMPLETED') {
            entity.completedDateTime = DateTime.now();
            entity.completedBy = completedBy;
          }
          entity.markDirty();
          await collection.put(entity);
        }
      }
    });
  }

  /// Delete enrollment and related data
  Future<void> deleteWithRelatedData(String dhis2Id) async {
    await isar.writeTxn(() async {
      // Delete related events
      final events = await isar.eventIsars
          .where()
          .enrollmentEqualTo(dhis2Id)
          .findAll();
      
      await isar.eventIsars.deleteAll(events.map((e) => e.id).toList());
      
      // Delete enrollment
      final enrollment = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
      if (enrollment != null) {
        await collection.delete(enrollment.id);
      }
    });
  }

  /// Delete enrollments by tracked entity
  Future<void> deleteByTrackedEntity(String teiId) async {
    await isar.writeTxn(() async {
      final enrollments = await collection
          .where()
          .trackedEntityInstanceEqualTo(teiId)
          .findAll();
      
      for (final enrollment in enrollments) {
        await deleteWithRelatedData(enrollment.dhis2Id);
      }
    });
  }

  /// Get enrollment completion timeline
  Future<List<Map<String, dynamic>>> getCompletionTimeline({
    String? programId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    var query = collection.where();
    
    if (programId != null) {
      query = query.programEqualTo(programId);
    }
    
    query = query.and().statusEqualTo('COMPLETED').and().not().deletedEqualTo(true);
    
    if (startDate != null && endDate != null) {
      query = query.and().enrollmentDateTimestampBetween(
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      );
    }
    
    final enrollments = await query.sortByEnrollmentDateTimestamp().findAll();
    
    final Map<String, int> timeline = {};
    for (final enrollment in enrollments) {
      if (enrollment.enrollmentDate != null) {
        final date = enrollment.enrollmentDate!.split('T')[0]; // Get date part only
        timeline[date] = (timeline[date] ?? 0) + 1;
      }
    }
    
    return timeline.entries
        .map((e) => {'date': e.key, 'count': e.value})
        .toList()
      ..sort((a, b) => a['date'].compareTo(b['date']));
  }
}

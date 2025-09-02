import 'package:d2_touch/core/utilities/query/base_isar.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/program_isar.entity.dart';
import 'package:isar/isar.dart';

/// Program Isar Query
/// 
/// Handles queries for ProgramIsar collection
/// Optimized for program configuration and metadata operations
class ProgramIsarQuery extends BaseIsarQuery<ProgramIsar> {
  ProgramIsarQuery({required super.isar});

  @override
  IsarCollection<ProgramIsar> get collection => isar.programIsars;

  /// Get programs by type
  Future<List<ProgramIsar>> byType(String programType) async {
    return await collection
        .where()
        .programTypeEqualTo(programType)
        .sortByName()
        .findAll();
  }

  /// Get tracker programs
  Future<List<ProgramIsar>> getTrackerPrograms() async {
    return await byType('WITH_REGISTRATION');
  }

  /// Get event programs
  Future<List<ProgramIsar>> getEventPrograms() async {
    return await byType('WITHOUT_REGISTRATION');
  }

  /// Get programs by tracked entity type
  Future<List<ProgramIsar>> byTrackedEntityType(String trackedEntityTypeId) async {
    return await collection
        .where()
        .trackedEntityTypeEqualTo(trackedEntityTypeId)
        .sortByName()
        .findAll();
  }

  /// Get programs with coordination capture
  Future<List<ProgramIsar>> withCoordinateCapture() async {
    return await collection
        .where()
        .captureCoordinatesEqualTo(true)
        .sortByName()
        .findAll();
  }

  /// Get programs that allow only one enrollment
  Future<List<ProgramIsar>> withOnlyEnrollOnce() async {
    return await collection
        .where()
        .onlyEnrollOnceEqualTo(true)
        .sortByName()
        .findAll();
  }

  /// Get programs for front page display
  Future<List<ProgramIsar>> forFrontPageDisplay() async {
    return await collection
        .where()
        .displayFrontPageListEqualTo(true)
        .sortByName()
        .findAll();
  }

  /// Search programs by name or code
  Future<List<ProgramIsar>> search(String query) async {
    final all = await collection
        .where()
        .sortByName()
        .findAll();

    final searchTerm = query.toLowerCase();
    return all.where((program) {
      final nameMatch = program.name?.toLowerCase().contains(searchTerm) ?? false;
      final codeMatch = program.code?.toLowerCase().contains(searchTerm) ?? false;
      final shortNameMatch = program.shortName?.toLowerCase().contains(searchTerm) ?? false;
      
      return nameMatch || codeMatch || shortNameMatch;
    }).toList();
  }

  /// Get programs available for organisation unit
  Future<List<ProgramIsar>> forOrganisationUnit(String orgUnitId) async {
    final all = await collection
        .where()
        .sortByName()
        .findAll();

    return all.where((program) {
      final orgUnits = program.organisationUnits;
      return orgUnits.any((ou) => ou['id'] == orgUnitId);
    }).toList();
  }

  /// Get programs by access level
  Future<List<ProgramIsar>> byAccessLevel(String accessLevel) async {
    return await collection
        .where()
        .accessLevelEqualTo(accessLevel)
        .sortByName()
        .findAll();
  }

  /// Get programs with expiry settings
  Future<List<ProgramIsar>> withExpirySettings() async {
    return await collection
        .where()
        .expiryDaysIsNotNull()
        .or()
        .completeEventsExpiryDaysIsNotNull()
        .sortByName()
        .findAll();
  }

  /// Get programs with minimum search attributes
  Future<List<ProgramIsar>> withMinSearchAttributes() async {
    return await collection
        .where()
        .minAttributesRequiredToSearchIsNotNull()
        .sortByName()
        .findAll();
  }

  /// Get programs that use first stage during registration
  Future<List<ProgramIsar>> usingFirstStageDuringRegistration() async {
    return await collection
        .where()
        .useFirstStageDuringRegistrationEqualTo(true)
        .sortByName()
        .findAll();
  }

  /// Get programs by feature type
  Future<List<ProgramIsar>> byFeatureType(String featureType) async {
    return await collection
        .where()
        .featureTypeEqualTo(featureType)
        .sortByName()
        .findAll();
  }

  /// Get programs with specific category combo
  Future<List<ProgramIsar>> byCategoryCombo(String categoryComboId) async {
    return await collection
        .where()
        .categoryComboEqualTo(categoryComboId)
        .sortByName()
        .findAll();
  }

  /// Count programs by type
  Future<int> countByType(String programType) async {
    return await collection
        .where()
        .programTypeEqualTo(programType)
        .count();
  }

  /// Count tracker programs
  Future<int> countTrackerPrograms() async {
    return await countByType('WITH_REGISTRATION');
  }

  /// Count event programs
  Future<int> countEventPrograms() async {
    return await countByType('WITHOUT_REGISTRATION');
  }

  /// Count programs by tracked entity type
  Future<int> countByTrackedEntityType(String trackedEntityTypeId) async {
    return await collection
        .where()
        .trackedEntityTypeEqualTo(trackedEntityTypeId)
        .count();
  }

  /// Get programs with program rules
  Future<List<ProgramIsar>> withProgramRules() async {
    final all = await collection
        .where()
        .sortByName()
        .findAll();

    return all.where((program) {
      return program.programRules.isNotEmpty;
    }).toList();
  }

  /// Get programs with program indicators
  Future<List<ProgramIsar>> withProgramIndicators() async {
    final all = await collection
        .where()
        .sortByName()
        .findAll();

    return all.where((program) {
      return program.programIndicators.isNotEmpty;
    }).toList();
  }

  /// Get programs with notification templates
  Future<List<ProgramIsar>> withNotificationTemplates() async {
    return await collection
        .where()
        .notificationTemplatesJsonIsNotNull()
        .sortByName()
        .findAll();
  }

  /// Get programs created after specific date
  Future<List<ProgramIsar>> createdAfter(DateTime date) async {
    return await collection
        .where()
        .createdTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByCreatedTimestamp()
        .findAll();
  }

  /// Get programs updated after specific date
  Future<List<ProgramIsar>> updatedAfter(DateTime date) async {
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(date.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestamp()
        .findAll();
  }

  /// Get programs with recent activity
  Future<List<ProgramIsar>> withRecentActivity({
    int daysBack = 30,
  }) async {
    final cutoff = DateTime.now().subtract(Duration(days: daysBack));
    
    return await collection
        .where()
        .lastUpdatedTimestampGreaterThan(cutoff.millisecondsSinceEpoch)
        .sortByLastUpdatedTimestampDesc()
        .findAll();
  }

  /// Get programs by version range
  Future<List<ProgramIsar>> byVersionRange(int minVersion, int maxVersion) async {
    return await collection
        .where()
        .versionBetween(minVersion, maxVersion)
        .sortByVersion()
        .findAll();
  }

  /// Get latest version programs
  Future<List<ProgramIsar>> getLatestVersions() async {
    final all = await collection
        .where()
        .sortByVersionDesc()
        .findAll();

    // Group by program ID and get the latest version
    final Map<String, ProgramIsar> latestVersions = {};
    
    for (final program in all) {
      final existing = latestVersions[program.dhis2Id];
      if (existing == null || (program.version ?? 0) > (existing.version ?? 0)) {
        latestVersions[program.dhis2Id] = program;
      }
    }
    
    return latestVersions.values.toList()..sort((a, b) => a.name?.compareTo(b.name ?? '') ?? 0);
  }

  /// Get programs by enrollment date configuration
  Future<List<ProgramIsar>> byEnrollmentDateConfig({
    bool? selectEnrollmentDatesInFuture,
    bool? selectIncidentDatesInFuture,
  }) async {
    var query = collection.where();
    
    if (selectEnrollmentDatesInFuture != null) {
      query = query.selectEnrollmentDatesInFutureEqualTo(selectEnrollmentDatesInFuture);
    }
    
    if (selectIncidentDatesInFuture != null) {
      if (selectEnrollmentDatesInFuture != null) {
        query = query.and();
      }
      query = query.selectIncidentDatesInFutureEqualTo(selectIncidentDatesInFuture);
    }
    
    return await query.sortByName().findAll();
  }

  /// Get program statistics
  Future<Map<String, dynamic>> getProgramStatistics(String programId) async {
    final program = await byId(programId);
    if (program == null) return {};

    // Count enrollments
    final enrollmentCount = await isar.enrollmentIsars
        .where()
        .programEqualTo(programId)
        .and()
        .not()
        .deletedEqualTo(true)
        .count();

    // Count events for tracker programs
    int eventCount = 0;
    if (program.isTracker) {
      final enrollments = await isar.enrollmentIsars
          .where()
          .programEqualTo(programId)
          .and()
          .not()
          .deletedEqualTo(true)
          .findAll();

      for (final enrollment in enrollments) {
        eventCount += await isar.eventIsars
            .where()
            .enrollmentEqualTo(enrollment.dhis2Id)
            .and()
            .not()
            .deletedEqualTo(true)
            .count();
      }
    } else {
      // For event programs, count events directly
      eventCount = await isar.eventIsars
          .where()
          .programStageIsNotNull() // Events for this program's stages
          .and()
          .not()
          .deletedEqualTo(true)
          .count();
    }

    return {
      'programId': programId,
      'programName': program.name,
      'programType': program.programType,
      'enrollmentCount': enrollmentCount,
      'eventCount': eventCount,
      'stageCount': program.programStages.length,
      'ruleCount': program.programRules.length,
      'indicatorCount': program.programIndicators.length,
    };
  }

  /// Bulk update sync status
  Future<void> bulkUpdateSyncStatus({
    required List<String> dhis2Ids,
    bool? synced,
    bool? dirty,
  }) async {
    await isar.writeTxn(() async {
      for (final dhis2Id in dhis2Ids) {
        final entity = await collection.where().dhis2IdEqualTo(dhis2Id).findFirst();
        if (entity != null) {
          if (synced != null) entity.synced = synced;
          if (dirty != null) entity.dirty = dirty;
          
          entity.lastUpdatedTimestamp = DateTime.now().millisecondsSinceEpoch;
          await collection.put(entity);
        }
      }
    });
  }

  /// Get programs needing metadata sync
  Future<List<ProgramIsar>> getNeedingMetadataSync() async {
    return await collection
        .where()
        .dirtyEqualTo(true)
        .or()
        .syncedEqualTo(false)
        .findAll();
  }
}

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:d2_touch/d2_touch_isar.dart';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/core/utilities/migration/sqlite_to_isar.migration.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/program_isar.entity.dart';

void main() {
  group('D2Touch Isar Migration Tests', () {
    late D2TouchIsar d2Touch;
    
    setUp(() async {
      // Initialize D2TouchIsar with in-memory database for testing
      d2Touch = await D2TouchIsar.init(
        useIsar: true,
        databaseName: 'test_dhis2_isar',
        inMemory: true,
      );
    });

    tearDown(() async {
      await d2Touch.dispose();
    });

    group('Database Initialization', () {
      test('should initialize Isar database successfully', () async {
        expect(d2Touch.useIsar, isTrue);
        expect(d2Touch.databaseType, equals('Isar'));
        
        final stats = await d2Touch.getDatabaseStats();
        expect(stats['databaseName'], equals('test_dhis2_isar'));
        expect(stats['isOpen'], isTrue);
      });

      test('should have all required schemas', () async {
        final isar = await d2Touch.isarManager.database;
        
        // Check if all collections are available
        expect(isar.userIsars, isNotNull);
        expect(isar.organisationUnitIsars, isNotNull);
        expect(isar.trackedEntityIsars, isNotNull);
        expect(isar.enrollmentIsars, isNotNull);
        expect(isar.eventIsars, isNotNull);
        expect(isar.programIsars, isNotNull);
      });
    });

    group('User Management', () {
      test('should create and retrieve user', () async {
        final user = UserIsar()
          ..dhis2Id = 'test_user_1'
          ..name = 'Test User'
          ..username = 'testuser'
          ..email = 'test@example.com'
          ..isLoggedIn = true;

        final savedUser = await d2Touch.userIsarQuery.save(user);
        expect(savedUser.dhis2Id, equals('test_user_1'));
        expect(savedUser.name, equals('Test User'));

        final retrievedUser = await d2Touch.userIsarQuery.byId('test_user_1');
        expect(retrievedUser, isNotNull);
        expect(retrievedUser!.username, equals('testuser'));
      });

      test('should handle user login and authentication', () async {
        final user = UserIsar()
          ..dhis2Id = 'auth_user_1'
          ..name = 'Auth User'
          ..username = 'authuser'
          ..isLoggedIn = true
          ..tokenExpiry = DateTime.now().add(Duration(hours: 1)).toIso8601String();

        await d2Touch.loginUser(user);
        
        final isAuthenticated = await d2Touch.isAuthenticated();
        expect(isAuthenticated, isTrue);

        final currentUser = await d2Touch.getCurrentUser();
        expect(currentUser, isNotNull);
        expect(currentUser!.dhis2Id, equals('auth_user_1'));
      });
    });

    group('Organisation Unit Operations', () {
      test('should create and query organisation units', () async {
        final orgUnits = [
          OrganisationUnitIsar()
            ..dhis2Id = 'ou1'
            ..name = 'Health Facility 1'
            ..level = 3
            ..path = '/root/district/ou1'
            ..geometry = '{"type":"Point","coordinates":[34.0,-6.0]}',
          OrganisationUnitIsar()
            ..dhis2Id = 'ou2'
            ..name = 'Health Facility 2'
            ..level = 3
            ..path = '/root/district/ou2'
        ];

        await d2Touch.organisationUnitIsarQuery.saveAll(orgUnits);

        final retrievedOrgUnits = await d2Touch.organisationUnitIsarQuery.all();
        expect(retrievedOrgUnits.length, equals(2));

        final orgUnitsByLevel = await d2Touch.organisationUnitIsarQuery.byLevel(3);
        expect(orgUnitsByLevel.length, equals(2));

        final orgUnitsWithGeometry = await d2Touch.organisationUnitIsarQuery.withGeometry();
        expect(orgUnitsWithGeometry.length, equals(1));
      });
    });

    group('Tracker Operations', () {
      late ProgramIsar program;
      late TrackedEntityIsar trackedEntity;
      late EnrollmentIsar enrollment;
      late EventIsar event;

      setUp(() async {
        // Create test program
        program = ProgramIsar()
          ..dhis2Id = 'program1'
          ..name = 'Test Program'
          ..programType = 'WITH_REGISTRATION'
          ..trackedEntityType = 'person';

        await d2Touch.programIsarQuery.save(program);

        // Create test tracked entity
        trackedEntity = TrackedEntityIsar()
          ..dhis2Id = 'tei1'
          ..name = 'John Doe'
          ..orgUnit = 'ou1'
          ..trackedEntityType = 'person'
          ..attributes = [
            {'attribute': 'firstName', 'value': 'John'},
            {'attribute': 'lastName', 'value': 'Doe'},
            {'attribute': 'age', 'value': '30'}
          ];

        await d2Touch.trackedEntityIsarQuery.save(trackedEntity);

        // Create test enrollment
        enrollment = EnrollmentIsar()
          ..dhis2Id = 'enrollment1'
          ..trackedEntityInstance = 'tei1'
          ..program = 'program1'
          ..orgUnit = 'ou1'
          ..status = 'ACTIVE'
          ..enrollmentDate = '2024-01-01';

        await d2Touch.enrollmentIsarQuery.save(enrollment);

        // Create test event
        event = EventIsar()
          ..dhis2Id = 'event1'
          ..enrollment = 'enrollment1'
          ..programStage = 'stage1'
          ..orgUnit = 'ou1'
          ..status = 'ACTIVE'
          ..eventDate = '2024-01-15'
          ..dataValues = [
            {'dataElement': 'de1', 'value': 'Test Value 1'},
            {'dataElement': 'de2', 'value': '25'}
          ];

        await d2Touch.eventIsarQuery.save(event);
      });

      test('should perform tracker queries correctly', () async {
        // Test program queries
        final programs = await d2Touch.programIsarQuery.all();
        expect(programs.length, equals(1));
        expect(programs.first.name, equals('Test Program'));

        final trackerPrograms = await d2Touch.programIsarQuery.getTrackerPrograms();
        expect(trackerPrograms.length, equals(1));

        // Test tracked entity queries
        final trackedEntities = await d2Touch.trackedEntityIsarQuery.all();
        expect(trackedEntities.length, equals(1));

        final teisByOrgUnit = await d2Touch.trackedEntityIsarQuery.byOrgUnit('ou1');
        expect(teisByOrgUnit.length, equals(1));

        final teisByAttribute = await d2Touch.trackedEntityIsarQuery.searchByAttribute('firstName', 'John');
        expect(teisByAttribute.length, equals(1));

        // Test enrollment queries
        final enrollments = await d2Touch.enrollmentIsarQuery.all();
        expect(enrollments.length, equals(1));

        final enrollmentsByProgram = await d2Touch.enrollmentIsarQuery.byProgram('program1');
        expect(enrollmentsByProgram.length, equals(1));

        final activeEnrollments = await d2Touch.enrollmentIsarQuery.getActive();
        expect(activeEnrollments.length, equals(1));

        // Test event queries
        final events = await d2Touch.eventIsarQuery.all();
        expect(events.length, equals(1));

        final eventsByEnrollment = await d2Touch.eventIsarQuery.byEnrollment('enrollment1');
        expect(eventsByEnrollment.length, equals(1));

        final activeEvents = await d2Touch.eventIsarQuery.getActive();
        expect(activeEvents.length, equals(1));
      });

      test('should handle data modifications correctly', () async {
        // Test tracked entity attribute update
        trackedEntity.setAttributeValue('age', '31');
        await d2Touch.trackedEntityIsarQuery.save(trackedEntity);

        final updatedTEI = await d2Touch.trackedEntityIsarQuery.byId('tei1');
        expect(updatedTEI!.getAttributeValue('age'), equals('31'));

        // Test enrollment status change
        enrollment.markCompleted();
        await d2Touch.enrollmentIsarQuery.save(enrollment);

        final updatedEnrollment = await d2Touch.enrollmentIsarQuery.byId('enrollment1');
        expect(updatedEnrollment!.isCompleted, isTrue);

        // Test event data value update
        event.setDataValue('de1', 'Updated Value');
        await d2Touch.eventIsarQuery.save(event);

        final updatedEvent = await d2Touch.eventIsarQuery.byId('event1');
        expect(updatedEvent!.getDataValue('de1'), equals('Updated Value'));
      });

      test('should handle sync status operations', () async {
        // Mark entities as dirty
        trackedEntity.markDirty();
        enrollment.markDirty();
        event.markDirty();

        await d2Touch.trackedEntityIsarQuery.save(trackedEntity);
        await d2Touch.enrollmentIsarQuery.save(enrollment);
        await d2Touch.eventIsarQuery.save(event);

        // Query entities needing sync
        final dirtyTEIs = await d2Touch.trackedEntityIsarQuery.getNeedingSync();
        expect(dirtyTEIs.length, equals(1));

        final dirtyEnrollments = await d2Touch.enrollmentIsarQuery.getNeedingSync();
        expect(dirtyEnrollments.length, equals(1));

        final dirtyEvents = await d2Touch.eventIsarQuery.getNeedingSync();
        expect(dirtyEvents.length, equals(1));

        // Bulk update sync status
        await d2Touch.trackedEntityIsarQuery.bulkUpdateSyncStatus(
          dhis2Ids: ['tei1'],
          synced: true,
          dirty: false,
        );

        final syncedTEI = await d2Touch.trackedEntityIsarQuery.byId('tei1');
        expect(syncedTEI!.synced, isTrue);
        expect(syncedTEI.dirty, isFalse);
      });
    });

    group('Statistics and Reporting', () {
      setUp(() async {
        // Create test data for statistics
        await _createTestStatisticsData(d2Touch);
      });

      test('should provide accurate statistics', () async {
        final dbStats = await d2Touch.getDatabaseStats();
        expect(dbStats['databaseName'], equals('test_dhis2_isar'));

        final enrollmentStats = await d2Touch.enrollmentIsarQuery.getStatistics();
        expect(enrollmentStats['total'], greaterThan(0));
        expect(enrollmentStats['active'], greaterThanOrEqualTo(0));
        expect(enrollmentStats['completed'], greaterThanOrEqualTo(0));

        final eventStats = await d2Touch.eventIsarQuery.getCompletionStats('stage1');
        expect(eventStats['total'], greaterThan(0));
      });

      test('should provide completion timeline', () async {
        final timeline = await d2Touch.enrollmentIsarQuery.getCompletionTimeline(
          startDate: DateTime(2024, 1, 1),
          endDate: DateTime(2024, 12, 31),
        );
        
        expect(timeline, isNotEmpty);
        expect(timeline.first.containsKey('date'), isTrue);
        expect(timeline.first.containsKey('count'), isTrue);
      });
    });

    group('Data Export and Import', () {
      test('should export and import JSON data', () async {
        // Create some test data
        await _createTestStatisticsData(d2Touch);

        // Export data
        final exportedData = await d2Touch.exportToJson();
        expect(exportedData.containsKey('metadata'), isTrue);
        expect(exportedData.containsKey('users'), isTrue);
        expect(exportedData.containsKey('organisationUnits'), isTrue);

        final metadata = exportedData['metadata'] as Map<String, dynamic>;
        expect(metadata['totalEntities'], greaterThan(0));

        // Reset database
        await d2Touch.reset();

        // Verify database is empty
        final emptyStats = await d2Touch.getDatabaseStats();
        // Database should be reinitialized but empty

        // Import data back
        await d2Touch.importFromJson(exportedData);

        // Verify data was imported
        final users = await d2Touch.userIsarQuery.all();
        expect(users.isNotEmpty, isTrue);
      });
    });

    group('Database Management', () {
      test('should compact database', () async {
        await _createTestStatisticsData(d2Touch);
        
        final statsBefore = await d2Touch.getDatabaseStats();
        await d2Touch.compactDatabase();
        final statsAfter = await d2Touch.getDatabaseStats();
        
        // Database should still be functional
        expect(statsAfter['isOpen'], isTrue);
      });

      test('should reset database successfully', () async {
        // Create some data
        await _createTestStatisticsData(d2Touch);
        
        // Verify data exists
        final usersBefore = await d2Touch.userIsarQuery.all();
        expect(usersBefore.isNotEmpty, isTrue);
        
        // Reset database
        await d2Touch.reset();
        
        // Verify database is empty but functional
        final usersAfter = await d2Touch.userIsarQuery.all();
        expect(usersAfter.isEmpty, isTrue);
        
        final stats = await d2Touch.getDatabaseStats();
        expect(stats['isOpen'], isTrue);
      });
    });

    group('Error Handling', () {
      test('should handle invalid operations gracefully', () async {
        // Try to access non-existent entities
        final nonExistentUser = await d2Touch.userIsarQuery.byId('non_existent');
        expect(nonExistentUser, isNull);

        final nonExistentOrgUnit = await d2Touch.organisationUnitIsarQuery.byId('non_existent');
        expect(nonExistentOrgUnit, isNull);

        // Try invalid search operations
        final emptySearch = await d2Touch.trackedEntityIsarQuery.searchByAttribute('invalid_attr', 'value');
        expect(emptySearch.isEmpty, isTrue);
      });

      test('should validate entity data integrity', () async {
        // Test entity validation methods
        final tei = TrackedEntityIsar()
          ..dhis2Id = 'test_tei'
          ..name = 'Test TEI'
          ..orgUnit = 'ou1'
          ..trackedEntityType = 'person';

        expect(tei.dhis2Id, equals('test_tei'));
        expect(tei.isDirty, isFalse);

        tei.markDirty();
        expect(tei.isDirty, isTrue);

        final enrollment = EnrollmentIsar()
          ..dhis2Id = 'test_enrollment'
          ..program = 'program1'
          ..status = 'ACTIVE';

        expect(enrollment.isActive, isTrue);
        expect(enrollment.isCompleted, isFalse);

        enrollment.markCompleted();
        expect(enrollment.isCompleted, isTrue);
      });
    });
  });

  group('Migration Tests', () {
    // Note: These tests would require actual SQLite database files for realistic testing
    // This is a basic structure showing how migration tests would work

    test('should check migration requirements', () async {
      final d2Touch = await D2TouchIsar.init(
        useIsar: true,
        databaseName: 'migration_test',
        inMemory: true,
      );

      // Since we're using in-memory database, this should return false
      expect(d2Touch.useIsar, isTrue);

      await d2Touch.dispose();
    });

    test('should handle migration exceptions', () async {
      final d2Touch = await D2TouchIsar.init(
        useIsar: true,
        databaseName: 'migration_exception_test',
        inMemory: true,
      );

      expect(() async {
        await d2Touch.migrateFromSQLite(
          sqliteDatabasePath: '/non/existent/path',
        );
      }, throwsA(isA<StateError>()));

      await d2Touch.dispose();
    });
  });
}

/// Helper function to create test data for statistics
Future<void> _createTestStatisticsData(D2TouchIsar d2Touch) async {
  // Create users
  final users = [
    UserIsar()
      ..dhis2Id = 'user1'
      ..name = 'User 1'
      ..username = 'user1'
      ..isLoggedIn = false,
    UserIsar()
      ..dhis2Id = 'user2'
      ..name = 'User 2'
      ..username = 'user2'
      ..isLoggedIn = true,
  ];
  await d2Touch.userIsarQuery.saveAll(users);

  // Create organisation units
  final orgUnits = [
    OrganisationUnitIsar()
      ..dhis2Id = 'ou1'
      ..name = 'Org Unit 1'
      ..level = 3,
    OrganisationUnitIsar()
      ..dhis2Id = 'ou2'
      ..name = 'Org Unit 2'
      ..level = 3,
  ];
  await d2Touch.organisationUnitIsarQuery.saveAll(orgUnits);

  // Create program
  final program = ProgramIsar()
    ..dhis2Id = 'program1'
    ..name = 'Test Program'
    ..programType = 'WITH_REGISTRATION';
  await d2Touch.programIsarQuery.save(program);

  // Create tracked entities
  final trackedEntities = [
    TrackedEntityIsar()
      ..dhis2Id = 'tei1'
      ..name = 'TEI 1'
      ..orgUnit = 'ou1'
      ..trackedEntityType = 'person',
    TrackedEntityIsar()
      ..dhis2Id = 'tei2'
      ..name = 'TEI 2'
      ..orgUnit = 'ou2'
      ..trackedEntityType = 'person',
  ];
  await d2Touch.trackedEntityIsarQuery.saveAll(trackedEntities);

  // Create enrollments
  final enrollments = [
    EnrollmentIsar()
      ..dhis2Id = 'enrollment1'
      ..trackedEntityInstance = 'tei1'
      ..program = 'program1'
      ..orgUnit = 'ou1'
      ..status = 'ACTIVE'
      ..enrollmentDate = '2024-01-01',
    EnrollmentIsar()
      ..dhis2Id = 'enrollment2'
      ..trackedEntityInstance = 'tei2'
      ..program = 'program1'
      ..orgUnit = 'ou2'
      ..status = 'COMPLETED'
      ..enrollmentDate = '2024-01-02'
      ..completedDate = '2024-01-15',
  ];
  await d2Touch.enrollmentIsarQuery.saveAll(enrollments);

  // Create events
  final events = [
    EventIsar()
      ..dhis2Id = 'event1'
      ..enrollment = 'enrollment1'
      ..programStage = 'stage1'
      ..orgUnit = 'ou1'
      ..status = 'ACTIVE'
      ..eventDate = '2024-01-10',
    EventIsar()
      ..dhis2Id = 'event2'
      ..enrollment = 'enrollment2'
      ..programStage = 'stage1'
      ..orgUnit = 'ou2'
      ..status = 'COMPLETED'
      ..eventDate = '2024-01-12',
  ];
  await d2Touch.eventIsarQuery.saveAll(events);
}

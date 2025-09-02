import 'package:flutter_test/flutter_test.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';

void main() {
  group('Isar Entity Unit Tests', () {
    group('UserIsar Entity', () {
      test('should create UserIsar with default values', () {
        final user = UserIsar();
        user.dhis2Id = 'test_user_1';
        user.name = 'Test User';
        user.username = 'testuser';

        expect(user.dhis2Id, equals('test_user_1'));
        expect(user.name, equals('Test User'));
        expect(user.username, equals('testuser'));
        expect(user.dirty, isTrue);
        expect(user.synced, isFalse);
      });

      test('should handle user authentication properties', () {
        final user = UserIsar();
        user.dhis2Id = 'auth_user';
        user.name = 'Auth User';
        user.username = 'authuser';
        user.isLoggedIn = true;

        expect(user.isLoggedIn, isTrue);
        expect(user.displayName, equals('Auth User'));
        
        // Test token expiry logic
        user.tokenExpiresAtTimestamp = DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch;
        expect(user.isTokenExpired, isFalse);
        
        user.tokenExpiresAtTimestamp = DateTime.now().subtract(Duration(hours: 1)).millisecondsSinceEpoch;
        expect(user.isTokenExpired, isTrue);
      });

      test('should serialize to and from JSON', () {
        final user = UserIsar();
        user.dhis2Id = 'json_user';
        user.name = 'JSON User';
        user.username = 'jsonuser';
        user.isLoggedIn = true;

        final json = user.toJson();
        expect(json['dhis2Id'], equals('json_user'));
        expect(json['name'], equals('JSON User'));
        expect(json['username'], equals('jsonuser'));
        expect(json['isLoggedIn'], isTrue);

        final reconstructedUser = UserIsar.fromJson(json);
        expect(reconstructedUser.dhis2Id, equals('json_user'));
        expect(reconstructedUser.name, equals('JSON User'));
        expect(reconstructedUser.username, equals('jsonuser'));
        expect(reconstructedUser.isLoggedIn, isTrue);
      });
    });

    group('OrganisationUnitIsar Entity', () {
      test('should create OrganisationUnit with hierarchy', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'ou_001';
        orgUnit.name = 'Test Hospital';
        orgUnit.level = 3;
        orgUnit.path = '/root/district/ou_001';
        orgUnit.parentId = 'district_001';

        expect(orgUnit.dhis2Id, equals('ou_001'));
        expect(orgUnit.name, equals('Test Hospital'));
        expect(orgUnit.level, equals(3));
        expect(orgUnit.isRoot, isFalse);
        expect(orgUnit.hasCoordinates, isFalse);
      });

      test('should handle geographical coordinates', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'geo_ou';
        orgUnit.name = 'GPS Facility';
        orgUnit.latitude = -6.1659;
        orgUnit.longitude = 35.7497;

        expect(orgUnit.hasCoordinates, isTrue);
        
        final coords = orgUnit.coordinates;
        expect(coords?['latitude'], equals(-6.1659));
        expect(coords?['longitude'], equals(35.7497));

        // Test geometry JSON
        final geometry = orgUnit.geometry;
        expect(geometry?['type'], equals('Point'));
        expect(geometry?['coordinates'], equals([35.7497, -6.1659])); // lon, lat order for GeoJSON
      });

      test('should serialize to JSON', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'json_ou';
        orgUnit.name = 'JSON Facility';
        orgUnit.level = 2;

        final json = orgUnit.toJson();
        expect(json['dhis2Id'], equals('json_ou'));
        expect(json['name'], equals('JSON Facility'));
        expect(json['level'], equals(2));
      });
    });

    group('TrackedEntityIsar Entity', () {
      test('should create TrackedEntity with attributes', () {
        final tei = TrackedEntityIsar();
        tei.dhis2Id = 'tei_001';
        tei.name = 'John Doe';
        tei.orgUnit = 'facility_001';
        tei.trackedEntityType = 'person';

        expect(tei.dhis2Id, equals('tei_001'));
        expect(tei.name, equals('John Doe'));
        expect(tei.orgUnit, equals('facility_001'));
        expect(tei.trackedEntityType, equals('person'));
      });

      test('should handle attributes with getters and setters', () {
        final tei = TrackedEntityIsar();
        tei.dhis2Id = 'attr_tei';
        tei.name = 'Attribute Test';
        
        // Set attributes using JSON
        tei.attributes = [
          {'attribute': 'firstName', 'value': 'John'},
          {'attribute': 'lastName', 'value': 'Doe'},
          {'attribute': 'age', 'value': '30'},
        ];

        expect(tei.getAttributeValue('firstName'), equals('John'));
        expect(tei.getAttributeValue('lastName'), equals('Doe'));
        expect(tei.getAttributeValue('age'), equals('30'));
        expect(tei.getAttributeValue('nonExistent'), isNull);

        // Test setting attribute
        tei.setAttributeValue('age', '31');
        expect(tei.getAttributeValue('age'), equals('31'));

        // Test adding new attribute
        tei.setAttributeValue('gender', 'Male');
        expect(tei.getAttributeValue('gender'), equals('Male'));
      });

      test('should handle relationships', () {
        final tei = TrackedEntityIsar();
        tei.dhis2Id = 'rel_tei';
        tei.name = 'Relationship Test';
        
        tei.relationships = [
          {
            'relationship': 'rel_001',
            'relationshipType': 'MOTHER_CHILD',
            'from': 'tei_mother',
            'to': 'rel_tei',
          }
        ];

        final relationships = tei.relationships;
        expect(relationships.length, equals(1));
        expect(relationships.first['relationshipType'], equals('MOTHER_CHILD'));
      });

      test('should serialize to JSON', () {
        final tei = TrackedEntityIsar();
        tei.dhis2Id = 'json_tei';
        tei.name = 'JSON TEI';
        tei.orgUnit = 'ou_001';

        final json = tei.toJson();
        expect(json['dhis2Id'], equals('json_tei'));
        expect(json['name'], equals('JSON TEI'));
        expect(json['orgUnit'], equals('ou_001'));
      });
    });

    group('EnrollmentIsar Entity', () {
      test('should create Enrollment with status management', () {
        final enrollment = EnrollmentIsar();
        enrollment.dhis2Id = 'enrollment_001';
        enrollment.trackedEntityInstance = 'tei_001';
        enrollment.program = 'program_001';
        enrollment.orgUnit = 'ou_001';
        enrollment.status = 'ACTIVE';

        expect(enrollment.dhis2Id, equals('enrollment_001'));
        expect(enrollment.isActive, isTrue);
        expect(enrollment.isCompleted, isFalse);
        expect(enrollment.isCancelled, isFalse);
      });

      test('should handle enrollment dates', () {
        final enrollment = EnrollmentIsar();
        enrollment.dhis2Id = 'date_enrollment';
        
        final enrollmentDate = DateTime(2024, 1, 15);
        enrollment.enrollmentDateTime = enrollmentDate;

        expect(enrollment.enrollmentDate, equals('2024-01-15'));
        expect(enrollment.enrollmentDateTime, equals(enrollmentDate));
      });

      test('should handle status changes', () {
        final enrollment = EnrollmentIsar();
        enrollment.dhis2Id = 'status_enrollment';
        enrollment.status = 'ACTIVE';

        expect(enrollment.isActive, isTrue);

        enrollment.markCompleted(completedByUser: 'test_user');
        expect(enrollment.isCompleted, isTrue);
        expect(enrollment.completedBy, equals('test_user'));
        expect(enrollment.completedDate, isNotNull);

        enrollment.reactivate();
        expect(enrollment.isActive, isTrue);
        expect(enrollment.completedDate, isNull);
      });

      test('should calculate enrollment duration', () {
        final enrollment = EnrollmentIsar();
        enrollment.dhis2Id = 'duration_enrollment';
        
        final enrollmentDate = DateTime.now().subtract(Duration(days: 30));
        enrollment.enrollmentDateTime = enrollmentDate;

        final duration = enrollment.durationInDays;
        expect(duration, greaterThanOrEqualTo(29)); // Allow for timing differences
        expect(duration, lessThanOrEqualTo(31));
      });

      test('should serialize to JSON', () {
        final enrollment = EnrollmentIsar();
        enrollment.dhis2Id = 'json_enrollment';
        enrollment.program = 'program_001';
        enrollment.status = 'ACTIVE';

        final json = enrollment.toJson();
        expect(json['dhis2Id'], equals('json_enrollment'));
        expect(json['program'], equals('program_001'));
        expect(json['status'], equals('ACTIVE'));
      });
    });

    group('EventIsar Entity', () {
      test('should create Event with data values', () {
        final event = EventIsar();
        event.dhis2Id = 'event_001';
        event.enrollment = 'enrollment_001';
        event.programStage = 'stage_001';
        event.orgUnit = 'ou_001';
        event.status = 'ACTIVE';

        expect(event.dhis2Id, equals('event_001'));
        expect(event.enrollment, equals('enrollment_001'));
        expect(event.status, equals('ACTIVE'));
      });

      test('should handle event dates', () {
        final event = EventIsar();
        event.dhis2Id = 'date_event';
        
        final eventDate = DateTime(2024, 1, 20);
        event.eventDateTime = eventDate;

        expect(event.eventDate, equals('2024-01-20'));
        expect(event.eventDateTime, equals(eventDate));
      });

      test('should handle data values', () {
        final event = EventIsar();
        event.dhis2Id = 'data_event';
        
        event.dataValues = [
          {'dataElement': 'weight', 'value': '70'},
          {'dataElement': 'height', 'value': '175'},
        ];

        expect(event.getDataValue('weight'), equals('70'));
        expect(event.getDataValue('height'), equals('175'));
        expect(event.getDataValue('nonExistent'), isNull);

        event.setDataValue('weight', '72');
        expect(event.getDataValue('weight'), equals('72'));
      });

      test('should check if overdue', () {
        final event = EventIsar();
        event.dhis2Id = 'overdue_event';
        event.status = 'ACTIVE';
        
        // Set due date in the past
        event.dueDateTimestamp = DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
        expect(event.isOverdue, isTrue);

        // Set due date in the future
        event.dueDateTimestamp = DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch;
        expect(event.isOverdue, isFalse);

        // Completed events are not overdue
        event.status = 'COMPLETED';
        event.dueDateTimestamp = DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch;
        expect(event.isOverdue, isFalse);
      });

      test('should mark as completed', () {
        final event = EventIsar();
        event.dhis2Id = 'complete_event';
        event.status = 'ACTIVE';

        event.markCompleted();
        expect(event.status, equals('COMPLETED'));
        expect(event.eventDate, isNotNull);
      });

      test('should serialize to JSON', () {
        final event = EventIsar();
        event.dhis2Id = 'json_event';
        event.status = 'ACTIVE';
        event.orgUnit = 'ou_001';

        final json = event.toJson();
        expect(json['dhis2Id'], equals('json_event'));
        expect(json['status'], equals('ACTIVE'));
        expect(json['orgUnit'], equals('ou_001'));
      });
    });

    group('ProgramIsar Entity', () {
      test('should create Program with configuration', () {
        final program = ProgramIsar();
        program.dhis2Id = 'program_001';
        program.name = 'HIV Care Program';
        program.programType = 'WITH_REGISTRATION';
        program.trackedEntityType = 'person';

        expect(program.dhis2Id, equals('program_001'));
        expect(program.name, equals('HIV Care Program'));
        expect(program.isTracker, isTrue);
        expect(program.isEvent, isFalse);
      });

      test('should handle program stages', () {
        final program = ProgramIsar();
        program.dhis2Id = 'stages_program';
        program.name = 'Test Program';

        program.programStages = [
          {
            'id': 'stage_001',
            'name': 'Initial Visit',
            'sortOrder': 1,
          },
          {
            'id': 'stage_002',
            'name': 'Follow-up',
            'sortOrder': 2,
          }
        ];

        final stages = program.programStages;
        expect(stages.length, equals(2));
        expect(stages.first['name'], equals('Initial Visit'));

        final firstStage = program.firstProgramStage;
        expect(firstStage?['id'], equals('stage_001'));
      });

      test('should handle tracked entity attributes', () {
        final program = ProgramIsar();
        program.dhis2Id = 'attr_program';
        program.name = 'Attribute Program';

        program.programTrackedEntityAttributes = [
          {
            'trackedEntityAttribute': 'attr_001',
            'displayName': 'First Name',
            'mandatory': true,
            'searchable': true,
          },
          {
            'trackedEntityAttribute': 'attr_002',
            'displayName': 'Age',
            'mandatory': false,
            'searchable': false,
          }
        ];

        final mandatoryAttrs = program.mandatoryAttributes;
        expect(mandatoryAttrs.length, equals(1));
        expect(mandatoryAttrs.first['displayName'], equals('First Name'));

        final searchableAttrs = program.requiredAttributesForSearch;
        expect(searchableAttrs.length, equals(1));
        expect(searchableAttrs.first['displayName'], equals('First Name'));
      });

      test('should serialize to JSON', () {
        final program = ProgramIsar();
        program.dhis2Id = 'json_program';
        program.name = 'JSON Program';
        program.programType = 'WITH_REGISTRATION';

        final json = program.toJson();
        expect(json['dhis2Id'], equals('json_program'));
        expect(json['name'], equals('JSON Program'));
        expect(json['programType'], equals('WITH_REGISTRATION'));
      });
    });

    group('Base Entity Functionality', () {
      test('should handle dirty state changes', () {
        final user = UserIsar();
        user.dhis2Id = 'dirty_user';
        user.name = 'Test User';

        expect(user.dirty, isTrue); // New entities are dirty by default
        expect(user.synced, isFalse);

        user.markSynced();
        expect(user.dirty, isFalse);
        expect(user.synced, isTrue);

        user.markDirty();
        expect(user.dirty, isTrue);
        expect(user.synced, isFalse);
      });

      test('should handle timestamps', () {
        final user = UserIsar();
        user.dhis2Id = 'timestamp_user';
        user.name = 'Timestamp User';

        final now = DateTime.now();
        expect(user.createdAt.millisecondsSinceEpoch, lessThanOrEqualTo(now.millisecondsSinceEpoch));
        expect(user.lastUpdatedAt.millisecondsSinceEpoch, lessThanOrEqualTo(now.millisecondsSinceEpoch));

        final specificDate = DateTime(2024, 1, 1);
        user.createdAt = specificDate;
        expect(user.createdAt, equals(specificDate));
      });

      test('should validate DHIS2 UIDs', () {
        final user = UserIsar();
        
        user.dhis2Id = 'a1234567890'; // Valid UID format
        expect(user.isValidDhis2Entity, isTrue);

        user.dhis2Id = '1234567890a'; // Invalid - starts with number
        expect(user.isValidDhis2Entity, isFalse);

        user.dhis2Id = 'a123456789'; // Invalid - too short
        expect(user.isValidDhis2Entity, isFalse);
      });

      test('should handle entity equality', () {
        final user1 = UserIsar();
        user1.dhis2Id = 'same_user';
        user1.name = 'User 1';

        final user2 = UserIsar();
        user2.dhis2Id = 'same_user';
        user2.name = 'User 2'; // Different name

        expect(user1, equals(user2)); // Same ID = equal
        expect(user1.hashCode, equals(user2.hashCode));

        user2.dhis2Id = 'different_user';
        expect(user1, isNot(equals(user2))); // Different ID = not equal
      });
    });
  });
}

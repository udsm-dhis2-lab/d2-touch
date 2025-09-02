import 'package:flutter_test/flutter_test.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';

void main() {
  group('Basic Isar Entity Tests', () {
    group('UserIsar Entity', () {
      test('should create UserIsar with default values', () {
        final user = UserIsar();
        user.dhis2Id = 'test_user_1';
        user.name = 'Test User';
        user.username = 'testuser';
        user.baseUrl = 'https://play.dhis2.org';

        expect(user.dhis2Id, equals('test_user_1'));
        expect(user.name, equals('Test User'));
        expect(user.username, equals('testuser'));
        expect(user.baseUrl, equals('https://play.dhis2.org'));
        expect(user.dirty, isTrue);
        expect(user.synced, isFalse);
        expect(user.isLoggedIn, isFalse);
      });

      test('should handle user authentication properties', () {
        final user = UserIsar();
        user.dhis2Id = 'auth_user';
        user.name = 'Auth User';
        user.firstName = 'Auth';
        user.surname = 'User';
        user.username = 'authuser';
        user.baseUrl = 'https://test.dhis2.org';
        user.isLoggedIn = true;

        expect(user.isLoggedIn, isTrue);
        expect(user.fullName, equals('Auth User'));
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
        user.firstName = 'JSON';
        user.surname = 'User';
        user.username = 'jsonuser';
        user.baseUrl = 'https://json.dhis2.org';
        user.isLoggedIn = true;

        final json = user.toJson();
        expect(json['dhis2Id'], equals('json_user'));
        expect(json['name'], equals('JSON User'));
        expect(json['firstName'], equals('JSON'));
        expect(json['surname'], equals('User'));
        expect(json['username'], equals('jsonuser'));
        expect(json['baseUrl'], equals('https://json.dhis2.org'));
        expect(json['isLoggedIn'], isTrue);

        final reconstructedUser = UserIsar.fromJson(json);
        expect(reconstructedUser.dhis2Id, equals('json_user'));
        expect(reconstructedUser.name, equals('JSON User'));
        expect(reconstructedUser.firstName, equals('JSON'));
        expect(reconstructedUser.surname, equals('User'));
        expect(reconstructedUser.username, equals('jsonuser'));
        expect(reconstructedUser.baseUrl, equals('https://json.dhis2.org'));
        expect(reconstructedUser.isLoggedIn, isTrue);
      });

      test('should handle organisation units and authorities', () {
        final user = UserIsar();
        user.dhis2Id = 'ou_user';
        user.name = 'OU User';
        user.baseUrl = 'https://ou.dhis2.org';

        // Test organisation units
        user.organisationUnits = [
          {'id': 'ou1', 'name': 'Facility 1'},
          {'id': 'ou2', 'name': 'Facility 2'},
        ];

        final orgUnits = user.organisationUnits;
        expect(orgUnits.length, equals(2));
        expect(orgUnits.first['name'], equals('Facility 1'));
        expect(user.belongsToOrganisationUnit('ou1'), isTrue);
        expect(user.belongsToOrganisationUnit('ou3'), isFalse);

        // Test authorities
        user.authorities = ['F_TRACKED_ENTITY_INSTANCE_ADD', 'F_PROGRAM_PUBLIC_ADD'];
        final auths = user.authorities;
        expect(auths.length, equals(2));
        expect(user.hasAuthority('F_TRACKED_ENTITY_INSTANCE_ADD'), isTrue);
        expect(user.hasAuthority('F_NON_EXISTENT'), isFalse);
      });
    });

    group('OrganisationUnitIsar Entity', () {
      test('should create OrganisationUnit with basic properties', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'ou_001';
        orgUnit.name = 'Test Hospital';
        orgUnit.level = 3;
        orgUnit.path = '/root/district/ou_001';
        orgUnit.parentId = 'district_001';

        expect(orgUnit.dhis2Id, equals('ou_001'));
        expect(orgUnit.name, equals('Test Hospital'));
        expect(orgUnit.level, equals(3));
        expect(orgUnit.path, equals('/root/district/ou_001'));
        expect(orgUnit.parentId, equals('district_001'));
        expect(orgUnit.isRoot, isFalse);
        expect(orgUnit.isLeaf, isTrue);
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
      });

      test('should handle hierarchy operations', () {
        final parent = OrganisationUnitIsar();
        parent.dhis2Id = 'parent_ou';
        parent.name = 'Parent Facility';
        parent.level = 2;

        final child = OrganisationUnitIsar();
        child.dhis2Id = 'child_ou';
        child.name = 'Child Facility';
        child.level = 3;
        child.parentId = 'parent_ou';
        child.ancestorIds = ['root_ou', 'parent_ou'];

        expect(child.isRoot, isFalse);
        expect(child.isDescendantOf(parent), isTrue);
        expect(parent.isAncestorOf(child), isTrue);
        
        // Test adding children
        parent.addChild('child_ou');
        expect(parent.isLeaf, isFalse);
        expect(parent.childrenIds?.contains('child_ou'), isTrue);
      });

      test('should serialize to and from JSON', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'json_ou';
        orgUnit.name = 'JSON Facility';
        orgUnit.level = 2;
        orgUnit.latitude = -6.0;
        orgUnit.longitude = 35.0;

        final json = orgUnit.toJson();
        expect(json['dhis2Id'], equals('json_ou'));
        expect(json['name'], equals('JSON Facility'));
        expect(json['level'], equals(2));
        expect(json['latitude'], equals(-6.0));
        expect(json['longitude'], equals(35.0));

        final reconstructed = OrganisationUnitIsar.fromJson(json);
        expect(reconstructed.dhis2Id, equals('json_ou'));
        expect(reconstructed.name, equals('JSON Facility'));
        expect(reconstructed.level, equals(2));
        expect(reconstructed.latitude, equals(-6.0));
        expect(reconstructed.longitude, equals(35.0));
      });

      test('should handle opening dates', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'date_ou';
        orgUnit.name = 'Date Facility';

        final openingDate = DateTime(2020, 1, 15);
        orgUnit.openingDate_DateTime = openingDate;

        expect(orgUnit.openingDate, equals('2020-01-15T00:00:00.000'));
        expect(orgUnit.openingDate_DateTime, equals(openingDate));
        expect(orgUnit.openingDateTimestamp, equals(openingDate.millisecondsSinceEpoch));
      });
    });

    group('Base Entity Functionality', () {
      test('should handle dirty state changes', () {
        final user = UserIsar();
        user.dhis2Id = 'dirty_user';
        user.name = 'Test User';
        user.baseUrl = 'https://test.dhis2.org';

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
        user.baseUrl = 'https://timestamp.dhis2.org';

        final now = DateTime.now();
        expect(user.createdAt.millisecondsSinceEpoch, lessThanOrEqualTo(now.millisecondsSinceEpoch));
        expect(user.lastUpdatedAt.millisecondsSinceEpoch, lessThanOrEqualTo(now.millisecondsSinceEpoch));

        final specificDate = DateTime(2024, 1, 1);
        user.createdAt = specificDate;
        expect(user.createdAt, equals(specificDate));
      });

      test('should validate DHIS2 UIDs', () {
        final user = UserIsar();
        user.baseUrl = 'https://uid.dhis2.org';
        
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
        user1.baseUrl = 'https://equal1.dhis2.org';

        final user2 = UserIsar();
        user2.dhis2Id = 'same_user';
        user2.name = 'User 2'; // Different name
        user2.baseUrl = 'https://equal2.dhis2.org';

        expect(user1, equals(user2)); // Same ID = equal
        expect(user1.hashCode, equals(user2.hashCode));

        user2.dhis2Id = 'different_user';
        expect(user1, isNot(equals(user2))); // Different ID = not equal
      });

      test('should handle display names', () {
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'display_ou';
        orgUnit.name = 'Display Facility';
        orgUnit.displayNameValue = 'Custom Display Name';

        expect(orgUnit.displayName, equals('Custom Display Name'));
        expect(orgUnit.effectiveDisplayName, equals('Custom Display Name'));

        orgUnit.displayNameValue = null;
        expect(orgUnit.displayName, equals('Display Facility'));
        expect(orgUnit.effectiveDisplayName, equals('Display Facility'));
      });
    });
  });
}

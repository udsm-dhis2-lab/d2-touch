import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';

void main() {
  group('Isar Integration Tests', () {
    late Isar isar;

    setUp(() async {
      // Initialize Isar database in memory for testing
      isar = await Isar.open(
        [UserIsarSchema, OrganisationUnitIsarSchema],
        directory: '',
        name: 'test_db',
      );
    });

    tearDown(() async {
      await isar.clear();
      await isar.close();
    });

    group('UserIsar Database Operations', () {
      test('should save and retrieve user from Isar database', () async {
        // Create a new user
        final user = UserIsar();
        user.dhis2Id = 'test_user_001';
        user.name = 'Test User';
        user.firstName = 'Test';
        user.surname = 'User';
        user.username = 'testuser';
        user.baseUrl = 'https://test.dhis2.org';
        user.isLoggedIn = true;

        // Save to database
        await isar.writeTxn(() async {
          await isar.userIsars.put(user);
        });

        // Retrieve from database
        final retrievedUser = await isar.userIsars.where().dhis2IdEqualTo('test_user_001').findFirst();

        expect(retrievedUser, isNotNull);
        expect(retrievedUser!.dhis2Id, equals('test_user_001'));
        expect(retrievedUser.name, equals('Test User'));
        expect(retrievedUser.username, equals('testuser'));
        expect(retrievedUser.baseUrl, equals('https://test.dhis2.org'));
        expect(retrievedUser.isLoggedIn, isTrue);
      });

      test('should update user in Isar database', () async {
        // Create and save initial user
        final user = UserIsar();
        user.dhis2Id = 'update_user_001';
        user.name = 'Update User';
        user.firstName = 'Update';
        user.surname = 'User';
        user.username = 'updateuser';
        user.baseUrl = 'https://update.dhis2.org';
        user.isLoggedIn = false;

        await isar.writeTxn(() async {
          await isar.userIsars.put(user);
        });

        // Update the user
        user.isLoggedIn = true;
        user.token = 'new_auth_token';

        await isar.writeTxn(() async {
          await isar.userIsars.put(user);
        });

        // Verify update
        final updatedUser = await isar.userIsars.where().dhis2IdEqualTo('update_user_001').findFirst();
        expect(updatedUser!.isLoggedIn, isTrue);
        expect(updatedUser.token, equals('new_auth_token'));
      });

      test('should query users by username', () async {
        // Create multiple users
        final users = [
          UserIsar()
            ..dhis2Id = 'user_001'
            ..name = 'Alice Smith'
            ..firstName = 'Alice'
            ..surname = 'Smith'
            ..username = 'alice'
            ..baseUrl = 'https://alice.dhis2.org',
          UserIsar()
            ..dhis2Id = 'user_002'
            ..name = 'Bob Jones'
            ..firstName = 'Bob'
            ..surname = 'Jones'
            ..username = 'bob'
            ..baseUrl = 'https://bob.dhis2.org',
          UserIsar()
            ..dhis2Id = 'user_003'
            ..name = 'Charlie Brown'
            ..firstName = 'Charlie'
            ..surname = 'Brown'
            ..username = 'charlie'
            ..baseUrl = 'https://charlie.dhis2.org',
        ];

        // Save all users
        await isar.writeTxn(() async {
          await isar.userIsars.putAll(users);
        });

        // Query by username
        final aliceUser = await isar.userIsars.where().usernameEqualTo('alice').findFirst();
        expect(aliceUser, isNotNull);
        expect(aliceUser!.name, equals('Alice Smith'));

        // Query all users
        final allUsers = await isar.userIsars.where().findAll();
        expect(allUsers.length, equals(3));
      });

      test('should handle user authorities and organisation units', () async {
        final user = UserIsar();
        user.dhis2Id = 'auth_user_001';
        user.name = 'Authority User';
        user.firstName = 'Authority';
        user.surname = 'User';
        user.username = 'authuser';
        user.baseUrl = 'https://auth.dhis2.org';

        // Set authorities and organisation units
        user.authorities = ['F_TRACKED_ENTITY_INSTANCE_ADD', 'F_PROGRAM_PUBLIC_ADD'];
        user.organisationUnits = [
          {'id': 'ou_001', 'name': 'Hospital A'},
          {'id': 'ou_002', 'name': 'Clinic B'},
        ];

        await isar.writeTxn(() async {
          await isar.userIsars.put(user);
        });

        final retrievedUser = await isar.userIsars.where().dhis2IdEqualTo('auth_user_001').findFirst();
        expect(retrievedUser!.hasAuthority('F_TRACKED_ENTITY_INSTANCE_ADD'), isTrue);
        expect(retrievedUser.belongsToOrganisationUnit('ou_001'), isTrue);
        expect(retrievedUser.belongsToOrganisationUnit('ou_999'), isFalse);
      });
    });

    group('OrganisationUnitIsar Database Operations', () {
      test('should save and retrieve organisation unit from Isar database', () async {
        // Create a new organisation unit
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'ou_test_001';
        orgUnit.name = 'Test Hospital';
        orgUnit.level = 3;
        orgUnit.path = '/root/district/ou_test_001';
        orgUnit.parentId = 'district_001';
        orgUnit.latitude = -6.1659;
        orgUnit.longitude = 35.7497;

        // Save to database
        await isar.writeTxn(() async {
          await isar.organisationUnitIsars.put(orgUnit);
        });

        // Retrieve from database
        final retrieved = await isar.organisationUnitIsars.where().dhis2IdEqualTo('ou_test_001').findFirst();

        expect(retrieved, isNotNull);
        expect(retrieved!.dhis2Id, equals('ou_test_001'));
        expect(retrieved.name, equals('Test Hospital'));
        expect(retrieved.level, equals(3));
        expect(retrieved.hasCoordinates, isTrue);
        expect(retrieved.latitude, equals(-6.1659));
        expect(retrieved.longitude, equals(35.7497));
      });

      test('should query organisation units by level', () async {
        // Create organisation units at different levels
        final orgUnits = [
          OrganisationUnitIsar()
            ..dhis2Id = 'root_001'
            ..name = 'Country Root'
            ..level = 1
            ..path = '/root_001',
          OrganisationUnitIsar()
            ..dhis2Id = 'district_001'
            ..name = 'Test District'
            ..level = 2
            ..path = '/root_001/district_001'
            ..parentId = 'root_001',
          OrganisationUnitIsar()
            ..dhis2Id = 'facility_001'
            ..name = 'Test Facility'
            ..level = 3
            ..path = '/root_001/district_001/facility_001'
            ..parentId = 'district_001',
        ];

        await isar.writeTxn(() async {
          await isar.organisationUnitIsars.putAll(orgUnits);
        });

        // Query by level
        final level2Units = await isar.organisationUnitIsars.where().levelEqualTo(2).findAll();
        expect(level2Units.length, equals(1));
        expect(level2Units.first.name, equals('Test District'));

        // Query facilities (level 3)
        final facilities = await isar.organisationUnitIsars.where().levelEqualTo(3).findAll();
        expect(facilities.length, equals(1));
        expect(facilities.first.name, equals('Test Facility'));
      });

      test('should handle hierarchy relationships', () async {
        // Create parent-child hierarchy
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

        // Add child to parent
        parent.addChild('child_ou');

        await isar.writeTxn(() async {
          await isar.organisationUnitIsars.putAll([parent, child]);
        });

        // Retrieve and verify relationships
        final retrievedParent = await isar.organisationUnitIsars.where().dhis2IdEqualTo('parent_ou').findFirst();
        final retrievedChild = await isar.organisationUnitIsars.where().dhis2IdEqualTo('child_ou').findFirst();

        expect(retrievedParent!.isLeaf, isFalse);
        expect(retrievedParent.childrenIds!.contains('child_ou'), isTrue);
        expect(retrievedChild!.isRoot, isFalse);
        expect(retrievedChild.parentId, equals('parent_ou'));
      });

      test('should handle geographical queries', () async {
        // Create organisation units with different coordinates
        final orgUnits = [
          OrganisationUnitIsar()
            ..dhis2Id = 'dar_hospital'
            ..name = 'Dar es Salaam Hospital'
            ..latitude = -6.7924
            ..longitude = 39.2083,
          OrganisationUnitIsar()
            ..dhis2Id = 'arusha_clinic'
            ..name = 'Arusha Clinic'
            ..latitude = -3.3869
            ..longitude = 36.6830,
          OrganisationUnitIsar()
            ..dhis2Id = 'no_coords_facility'
            ..name = 'Facility Without Coordinates',
        ];

        await isar.writeTxn(() async {
          await isar.organisationUnitIsars.putAll(orgUnits);
        });

        // Query units with coordinates
        final allUnits = await isar.organisationUnitIsars.where().findAll();
        final unitsWithCoords = allUnits.where((unit) => unit.hasCoordinates).toList();

        expect(unitsWithCoords.length, equals(2));
        
        // Find Dar es Salaam hospital
        final darHospital = allUnits.firstWhere((unit) => unit.dhis2Id == 'dar_hospital');
        expect(darHospital.hasCoordinates, isTrue);
        expect(darHospital.coordinates!['latitude'], equals(-6.7924));
      });
    });

    group('Cross-Entity Operations', () {
      test('should handle operations involving both users and organisation units', () async {
        // Create organisation unit
        final orgUnit = OrganisationUnitIsar();
        orgUnit.dhis2Id = 'main_hospital';
        orgUnit.name = 'Main Hospital';
        orgUnit.level = 3;

        // Create user assigned to the organisation unit
        final user = UserIsar();
        user.dhis2Id = 'hospital_user';
        user.name = 'Hospital User';
        user.firstName = 'Hospital';
        user.surname = 'User';
        user.username = 'hospitaluser';
        user.baseUrl = 'https://hospital.dhis2.org';
        user.organisationUnits = [
          {'id': 'main_hospital', 'name': 'Main Hospital'}
        ];

        // Save both entities
        await isar.writeTxn(() async {
          await isar.organisationUnitIsars.put(orgUnit);
          await isar.userIsars.put(user);
        });

        // Retrieve and verify relationships
        final retrievedUser = await isar.userIsars.where().dhis2IdEqualTo('hospital_user').findFirst();
        final retrievedOrgUnit = await isar.organisationUnitIsars.where().dhis2IdEqualTo('main_hospital').findFirst();

        expect(retrievedUser!.belongsToOrganisationUnit('main_hospital'), isTrue);
        expect(retrievedOrgUnit!.name, equals('Main Hospital'));

        // Count entities
        final userCount = await isar.userIsars.count();
        final orgUnitCount = await isar.organisationUnitIsars.count();
        
        expect(userCount, equals(1));
        expect(orgUnitCount, equals(1));
      });
    });
  });
}

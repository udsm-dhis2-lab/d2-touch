import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import 'organisation_unit_module_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  UserQuery userQuery = UserQuery(database: db);

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();
  await UserOrganisationUnitQuery(database: db)
      .setData(user.organisationUnits)
      .save();

  OrganisationUnitQuery orgUnitQuery =
      D2Touch.organisationUnitModule.organisationUnit;

  final organisationUnit = OrganisationUnit(
      id: 'ImspTQPwCqd',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      parent: "{id: qtr8GGlm4gg}",
      dirty: false);

  var insertResult = await orgUnitQuery.setData(organisationUnit).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await orgUnitQuery.byId('ImspTQPwCqd').getOne();

  test('should return saved details', () {
    expect(result!.id, 'ImspTQPwCqd');
    expect(result!.name, 'Test 1');
    expect(result!.parent, '{id: qtr8GGlm4gg}');
  });

  List<OrganisationUnit>? userOrgUnits = await orgUnitQuery.getUserOrgUnits();

  test('should return user organisation units', () {
    expect(userOrgUnits?[0].id, 'ImspTQPwCqd');
    expect(userOrgUnits?[0].name, 'Test 1');
  });
}

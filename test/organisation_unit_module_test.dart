import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'organisation_unit_module_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  OrganisationUnitQuery orgUnitQuery =
      D2Touch.organisationUnitModule.organisationUnit;

  final organisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      parent: {"id": "qtr8GGlm4gg"},
      dirty: false);

  var insertResult = await orgUnitQuery.setData(organisationUnit).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await orgUnitQuery.byId('test1').getOne();

  test('should return saved details', () {
    expect(result!.id, 'test1');
    expect(result!.name, 'Test 1');
    expect(result!.parent, 'qtr8GGlm4gg');
  });
}

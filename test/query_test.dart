import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:d2_touch/shared/utilities/sort_order.util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'repository_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  final query = OrganisationUnitQuery(database: db);

  await query.create();

  test(
      'should return table name based on what has been passed on entity definition',
      () {
    expect(query.tableName, 'organisationunit');
  });

  final organisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      dirty: false);

  var insertResult = await query.setData(organisationUnit).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  final organisationUnitList = [
    OrganisationUnit(
        id: 'test2',
        name: "Test 2",
        level: 1,
        path: 'test2',
        shortName: 'Test 2',
        openingDate: '20-01-2020',
        dirty: false),
    OrganisationUnit(
        id: 'test3',
        name: "Test 3",
        level: 2,
        path: 'test3',
        shortName: 'Test 3',
        openingDate: '20-01-2020',
        dirty: false),
    OrganisationUnit(
        id: 'test4',
        name: "Test 4",
        level: 3,
        path: 'test4',
        shortName: 'Test 4',
        openingDate: '20-01-2020',
        dirty: false)
  ];

  var saveManyResponse = await query.setData(organisationUnitList).save();

  test('should return save success for saved list', () {
    expect(saveManyResponse, 1);
  });

  var result = await query.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
  });

  final updatedOrganisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1 (updated)",
      level: 1,
      path: 'test1',
      shortName: 'Test 1 (updated)',
      openingDate: '20-01-2020',
      dirty: false);

  var updateResult = await query.setData(updatedOrganisationUnit).save();

  test('should return success if data is updated into the database', () {
    expect(updateResult, 1);
  });

  var updatedResult = await query.byId('test1').getOne();

  test('should return updated details', () {
    expect(updatedResult.id, 'test1');
    expect(updatedResult.name, 'Test 1 (updated)');
  });

  var deleteResult = await query.byId('test1').delete();

  test('should return delete success', () {
    expect(deleteResult, 1);
  });

  var deletedResult = await query.byId('test1').getOne();
  test('should return null for deleted item', () {
    expect(deletedResult, null);
  });

  var resultByIds = await query.byIds(['test2', 'test3']).get();

  test("should return saved results based on passed ids", () {
    expect(resultByIds.length, 2);
  });

  final levelQuery = OrganisationUnitQuery(database: db);
  var resultByLevel =
      await levelQuery.where(attribute: 'level', value: 3).get();

  test("should return saved result for level 3", () {
    expect(resultByLevel[0].id, 'test4');
  });

  final lessThanQuery = OrganisationUnitQuery(database: db);
  var lessThanResult =
      await lessThanQuery.lessThan(attribute: 'level', value: 3).get();

  test("should return saved result whose level are less than 3", () {
    expect(lessThanResult.length, 2);
  });

  final lessThanEqualQuery = OrganisationUnitQuery(database: db);
  var lessThanEqualResult = await lessThanEqualQuery
      .lessThanOrEqual(attribute: 'level', value: 3)
      .get();

  test("should return saved result whose level are less than or equal to 3",
      () {
    expect(lessThanEqualResult.length, 3);
  });

  final greaterThanQuery = OrganisationUnitQuery(database: db);
  var greaterThanResult =
      await greaterThanQuery.greaterThan(attribute: 'level', value: 1).get();

  test("should return saved result whose level are greater than 1", () {
    expect(greaterThanResult.length, 2);
  });

  final greaterThanEqualQuery = OrganisationUnitQuery(database: db);
  var greaterThanEqualResult = await greaterThanEqualQuery
      .greaterThanOrEqual(attribute: 'level', value: 1)
      .get();

  test("should return saved result whose level are greater than or equal to 1",
      () {
    expect(greaterThanEqualResult.length, 3);
  });

  final allQuery = OrganisationUnitQuery(database: db);
  var allResults = await allQuery.get();

  test("should return all saved results", () {
    expect(allResults.length, 3);
  });

  final orderByQuery = OrganisationUnitQuery(database: db);
  var orderDescResult = await orderByQuery
      .orderBy(attribute: 'level', order: SortOrder.DESC)
      .get();

  test("should return ordered by level in descending order", () {
    expect(orderDescResult[0].level, 3);
    expect(orderDescResult[1].level, 2);
    expect(orderDescResult[2].level, 1);
  });

  var orderAscResult = await orderByQuery
      .orderBy(attribute: 'level', order: SortOrder.ASC)
      .get();

  test("should return ordered by level in ascending order", () {
    expect(orderAscResult[0].level, 1);
    expect(orderAscResult[1].level, 2);
    expect(orderAscResult[2].level, 3);
  });

  var selectResult = await orderByQuery
      .select(['id', 'name', 'shortName', 'path', 'openingDate', 'dirty'])
      .byId('test2')
      .getOne();

  test("should return only selected columns", () {
    expect(selectResult.level, null);
    expect(selectResult.id, 'test2');
    expect(selectResult.name, 'Test 2');
  });
}

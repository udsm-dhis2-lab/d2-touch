import 'package:dhis2_flutter_sdk/core/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'repository_test.reflectable.dart';

void main() async {
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  final repository = Repository<OrganisationUnit>();

  final columns =
      repository.columns.map((column) => column.columnQueryExpresion);

  test('should return columns based on entity definition', () {
    expect(columns, [
      'id TEXT PRIMARY KEY NOT NULL',
      'name TEXT NOT NULL',
      'displayname TEXT',
      'shortname TEXT',
      'lastupdated TEXT',
      'created TEXT',
      'code TEXT',
      'dirty BOOLEAN NOT NULL',
      'level INTEGER NOT NULL',
      'path TEXT NOT NULL',
      'externalAccess BOOLEAN',
      'openingDate TEXT NOT NULL',
      'geometry TEXT',
      'parent TEXT',
    ]);
  });

  test(
      'should return table name based on what has been passed on entity definition',
      () {
    expect(repository.entity.tableName, 'organisationunit');
  });

  test('should return create query expression', () {
    expect(repository.createQuery,
        'CREATE TABLE IF NOT EXISTS organisationunit (id TEXT PRIMARY KEY NOT NULL, name TEXT NOT NULL, displayname TEXT, shortname TEXT, lastupdated TEXT, created TEXT, code TEXT, dirty BOOLEAN NOT NULL, level INTEGER NOT NULL, path TEXT NOT NULL, externalAccess BOOLEAN, openingDate TEXT NOT NULL, geometry TEXT, parent TEXT)');
  });

  await repository.create(database: db);

  final organisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      dirty: false);

  var insertResult = await repository.insertOne(
      entity: organisationUnit.toJson(), database: db);

  test('should return success if save is successful', () {
    expect(insertResult, 1);
  });

  var result = await db.query(repository.entity.tableName);

  print(result);

  await db.close();
}

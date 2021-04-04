import 'package:dhis2_flutter_sdk/core/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'index_test.reflectable.dart';

void main() {
  initializeReflectable();
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
      'leaf BOOLEAN NOT NULL',
      'path TEXT NOT NULL',
      'favorite BOOLEAN NOT NULL',
      'externalAccess BOOLEAN NOT NULL',
      'openingDate TEXT NOT NULL',
      'geometry TEXT',
      'parent TEXT',
    ]);
  });

  test(
      'should return table name based on what has been passed on entity definition',
      () {
    expect(repository.tableName, 'organisationunit');
  });
}

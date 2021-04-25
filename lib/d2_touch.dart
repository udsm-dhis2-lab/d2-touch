library dhis2_flutter_sdk;

import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/organisation_unit.module.dart';
import 'package:sqflite/sqflite.dart';

import 'modules/metadata/data_element/data_element.module.dart';

class D2Touch {
  static Future<void> initialize(
      {String databaseName,
      bool inMemory,
      DatabaseFactory databaseFactory}) async {
    DatabaseManager(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    await DatabaseManager.instance.database;
    await OrganisationUnitModule.createTables();
    await DataElementModule.createTables();
  }

  static OrganisationUnitModule organisationUnitModule =
      OrganisationUnitModule();

  static DataElementModule dataElementModule = DataElementModule();
}

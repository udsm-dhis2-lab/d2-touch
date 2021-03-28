import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'index_test.reflectable.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  // const MethodChannel channel =
  //     MethodChannel('plugins.flutter.io/path_provider');
  // channel.setMockMethodCallHandler((MethodCall methodCall) async {
  //   return ".";
  // });

  // final databaseManager = DatabaseManager();
  // databaseManager.inMemory = true;

  // // const MethodChannel sqflite = MethodChannel('com.tekartik.sqflite');
  // // sqflite.setMockMethodCallHandler((MethodCall methodCall) async {
  // //   return ".";
  // // });

  // initializeReflectable();

  // final organisationUnit = await OrganisationUnitQuery().get();

  // print(organisationUnit);
  // test('adds one to input values', () {
  //   expect(organisationUnit, isA<OrganisationUnitQuery>());
  // });
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  await db.execute('''
  CREATE TABLE Product (
      id INTEGER PRIMARY KEY,
      title TEXT
  )
  ''');
  await db.insert('Product', <String, Object>{'title': 'Product 1'});
  await db.insert('Product', <String, Object>{'title': 'Product 2'});

  var result = await db.query('Product');
  print(result);
  // prints [{id: 1, title: Product 1}, {id: 2, title: Product 1}]
  await db.close();
}

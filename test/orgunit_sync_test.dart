import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'orgunit_sync_test.reflectable.dart';
import '../sample/org_unit.sample.dart';
import '../sample/current_user.sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
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
  final organisationUnitQuery = OrganisationUnitQuery(database: db);

  final dhisOrganisationUnits = sampleOrganisationUnits;

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/organisationUnits.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,level,path,externalAccess,openingDate,geometry,parent&paging=false',
    (server) => server.reply(200, dhisOrganisationUnits),
  );

  List<OrganisationUnit>? organisationUnits =
      await organisationUnitQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<OrganisationUnit> orgUnits = await organisationUnitQuery.get();

  test('should store all incoming organisation unit metadata', () {
    expect(orgUnits.length, 50);
  });
}

import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/tracked_entity_instance.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'tracked_entity_instance_sync_test.reflectable.dart';

import '../sample/tracked_entity_instances.sample.dart';
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

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/trackedEntityInstances.json?ou=DiszpKrYNg8&program=IpHINAT79UW&programStatus=ACTIVE&pageSize=50&order=lastUpdated:desc&fields=*',
    (server) => server.reply(200, sampleTrackedEntityInstances),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();
  final trackedEntityInstanceQuery = TrackedEntityInstanceQuery(database: db);

  List<TrackedEntityInstance>? trackedEntityInstanceDownload =
      await trackedEntityInstanceQuery
          .byOrgUnit('DiszpKrYNg8')
          .byProgram('IpHINAT79UW')
          .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<TrackedEntityInstance> trackedEntityInstances =
      await trackedEntityInstanceQuery.get();

  test('should store all incoming tracked entity instances', () {
    expect(trackedEntityInstances.length, 32);
  });
}

import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/queries/attribute_reserved_value.query.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import 'reserved_value_download_test.reflectable.dart';
import '../sample/program.sample.dart';
import '../sample/reserved_values.sample.dart';

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
    'https://play.dhis2.org/2.35.11/api/trackedEntityAttributes/lZGmxYbs97q/generateAndReserve?numberToReserve=100',
    (server) => server.reply(200, sampleReservedValues),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();

  List<Program> programs = [];
  samplePrograms['programs'].forEach((program) {
    programs.add(Program.fromJson({...program, 'dirty': false}));
  });

  await ProgramQuery().setData(programs).save();

  await D2Touch.trackerModule.attributeReservedValue.download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<AttributeReservedValue> attributeReservedValues =
      await AttributeReservedValueQuery().get();

  test('should store all incoming data value sets', () {
    expect(attributeReservedValues.length, 100);
  });
}

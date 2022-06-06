import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/queries/data_value_set.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/data_value_set.sample.dart';
import 'aggregate_sync_test.reflectable.dart';

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
    'https://play.dhis2.org/2.35.11/api/dataValueSets.json?dataSet=BfMAe6Itzgt&period=202201&orgUnit=bG0PlyD0iP3',
    (server) => server.reply(200, sampleDataValueSet),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();

  await D2Touch.aggregateModule.dataValueSet
      .byDataSet('BfMAe6Itzgt')
      .byOrgUnit('bG0PlyD0iP3')
      .byPeriod("202201")
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataValueSet> dataValueSets =
      await DataValueSetQuery().withDataValues().get();

  test('should store all incoming data value sets', () {
    expect(dataValueSets.length, 1);
    expect(dataValueSets[0].dataValues?.length, 31);
  });

  await DataValueSetQuery()
      .setData(DataValueSet(
          period: '202201',
          orgUnit: 'bG0PlyD0iP3',
          synced: false,
          dataSet: 'BfMAe6Itzgt',
          dirty: true))
      .save();

  DataValueSet updatedDataValueSet = await DataValueSetQuery()
      .withDataValues()
      .byId('BfMAe6Itzgt_bG0PlyD0iP3_202201')
      .getOne();

  test('should not replace existing local data', () {
    expect(updatedDataValueSet.completeDate, '2010-03-06T00:00:00.000+0000');
  });
}

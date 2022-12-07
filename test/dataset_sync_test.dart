import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element_option.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element_option.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dataset_sync_test.reflectable.dart';
import '../sample/current_user.sample.dart';
import '../sample/data_sets.sample.dart';

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
  final dataSetQuery = DataSetQuery(database: db);

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataSets.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired&dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]&paging=false',
    (server) => server.reply(200, sampleDataSets),
  );

  await dataSetQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataSet> dataSets = await dataSetQuery.get();

  test('should store all incoming data set metadata', () {
    expect(dataSets.length, 24);
  });

  List<DataSetElement> dataSetElements = await DataSetElementQuery().get();

  test('should store all incoming data set data elements', () {
    expect(dataSetElements.length, 123);
  });

  List<DataSetElementOption> dataSetElementOptions =
      await DataSetElementOptionQuery().get();

  test('should store all incoming data set data element options', () {
    expect(dataSetElementOptions.length, 4);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataSets.json?filter=id:in:[BfMAe6Itzgt,VTdjfLXXmoi]&fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired&dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]&paging=false',
    (server) => server.reply(200, chunkedSampleDataSets),
  );

  await dataSetQuery.byIds(['BfMAe6Itzgt', 'VTdjfLXXmoi']).download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataSet> newDataSets =
      await DataSetQuery().byIds(['BfMAe6Itzgt', 'VTdjfLXXmoi']).get();

  test('should store dataset given the ids', () {
    expect(newDataSets.length, 2);
  });
}

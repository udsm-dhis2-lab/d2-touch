import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/user/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/user/queries/user.query.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:d2_touch/modules/engine/validation_rule/models/validation_rule_result.model.dart';
import 'package:d2_touch/modules/engine/validation_rule/validation_rule_engine.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/validation_rule.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/data_sets.sample.dart';
import '../sample/validation_rule.sample.dart';
import 'validation_rule_test.reflectable.dart';

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
    (server) => server.reply(200, {
      "dataSets": [chunkedSampleDataSets['dataSets'][0]]
    }),
  );

  await dataSetQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/validationRules?dataSet=BfMAe6Itzgt&fields=id,name,displayName,created,lastUpdated,description,operator,instruction,displayInstruction,displayFormName,periodOffset,periodType,leftSide,rightSide',
    (server) => server.reply(200, sampleValidationRule),
  );

  await ValidationRuleQuery().download(
      (progress, complete) => {print(progress.message)},
      dioTestClient: dio);

  final DataValueSet dataValueSet = await D2Touch.aggregateModule.dataValueSet
      .byDataSet('BfMAe6Itzgt')
      .byOrgUnit('orgunitid')
      .byPeriod('202001')
      .create();

  await D2Touch.aggregateModule.dataValue
      .setData(DataValue(
          dataElement: 'YtbsuPPo010',
          attributeOptionCombo: '',
          categoryOptionCombo: 'Prlt0C1RF0s',
          dataValueSet: dataValueSet.id,
          value: '2',
          synced: false,
          dirty: true))
      .save();

  await D2Touch.aggregateModule.dataValue
      .setData(DataValue(
          dataElement: 'GCGfEY82Wz6',
          attributeOptionCombo: '',
          categoryOptionCombo: 'Prlt0C1RF0s',
          dataValueSet: dataValueSet.id,
          value: '3',
          synced: false,
          dirty: true))
      .save();

  ValidationRuleResult validationRuleResult =
      await ValidationRuleEngine.execute(
    dataValueSet: dataValueSet,
    dataSet: 'BfMAe6Itzgt',
  );

  test('should return validation rule actions', () {
    expect(validationRuleResult.validationRuleActions.length, 1);
  });
}

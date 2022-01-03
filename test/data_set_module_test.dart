import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data_set_module_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  DataSetQuery dataSetQuery = D2Touch.dataSetModule.dataSet;

  final dataElement = DataSet(
      id: 'test1',
      name: "Test 1",
      shortName: 'Test 1',
      timelyDays: 15,
      dirty: false,
      expiryDays: 15,
      formType: 'CUSTOM',
      openFuturePeriods: 2,
      periodType: 'MONTHLY');

  var insertResult = await dataSetQuery.setData(dataElement).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  DataSet? result = await dataSetQuery.byId('test1').getOne();

  test('should return saved details', () {
    expect(result!.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.timelyDays, 15);
    expect(result.expiryDays, 15);
    expect(result.formType, 'CUSTOM');
    expect(result.openFuturePeriods, 2);
  });
}

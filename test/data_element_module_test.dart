import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/data_element/queries/data_element.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'data_element_module_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  DataElementQuery dataElementQuery = D2Touch.dataElementModule.dataElement;

  final dataElement = DataElement(
      id: 'test1',
      name: "Test 1",
      shortName: 'Test 1',
      valueType: 'TEXT',
      aggregationType: 'SUM',
      dirty: false);

  var insertResult = await dataElementQuery.setData(dataElement).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await dataElementQuery.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.valueType, 'TEXT');
    expect(result.aggregationType, 'SUM');
  });
}

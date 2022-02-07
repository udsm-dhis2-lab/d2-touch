import 'package:dhis2_flutter_sdk/modules/metadata/data_element/queries/data_element.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/data_element/queries/data_element_option.query.dart';

class DataElementModule {
  static createTables() async {
    await DataElementQuery().createTable();
    await DataElementOptionQuery().createTable();
  }

  DataElementQuery get dataElement => DataElementQuery();

  DataElementOptionQuery get dataElementOption => DataElementOptionQuery();
}

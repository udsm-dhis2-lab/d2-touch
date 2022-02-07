import 'package:dhis2_flutter_sdk/modules/metadata/data_element/queries/data_element.query.dart';

class DataElementModule {
  static createTables() async {
    return await DataElementQuery().createTable();
  }

  DataElementQuery get dataElement => DataElementQuery();
}

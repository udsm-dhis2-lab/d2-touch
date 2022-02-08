import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set_element.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set_element_option.query.dart';

class DataSetModule {
  static createTables() async {
    await DataSetQuery().createTable();
    await DataSetElementQuery().createTable();
    await DataSetElementOptionQuery().createTable();
  }

  DataSetQuery get dataSet => DataSetQuery();

  DataSetElementQuery get dataSetElement => DataSetElementQuery();

  DataSetElementOptionQuery get dataSetElementOption =>
      DataSetElementOptionQuery();
}

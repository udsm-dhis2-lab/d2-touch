import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set.query.dart';

class DataSetModule {
  static createTables() async {
    return await DataSetQuery().createTable();
  }

  DataSetQuery get dataSet => DataSetQuery();
}

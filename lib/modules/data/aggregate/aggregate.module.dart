import 'package:dhis2_flutter_sdk/modules/data/aggregate/queries/data_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/queries/data_value_set.query.dart';

class AggregateModule {
  static createTables() async {
    await DataValueSetQuery().createTable();
    await DataValueQuery().createTable();
  }

  DataValueQuery get dataValue => DataValueQuery();

  DataValueSetQuery get dataValueSet => DataValueSetQuery();
}

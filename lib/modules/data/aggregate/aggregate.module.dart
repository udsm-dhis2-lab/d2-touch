import 'package:d2_touch/modules/data/aggregate/queries/data_value.query.dart';
import 'package:d2_touch/modules/data/aggregate/queries/data_value_set.query.dart';
import 'package:sqflite/sqflite.dart';

class AggregateModule {
  static createTables({required Database database}) async {
    await DataValueSetQuery(database: database).createTable();
    await DataValueQuery(database: database).createTable();
  }

  DataValueQuery get dataValue => DataValueQuery();

  DataValueSetQuery get dataValueSet => DataValueSetQuery();
}

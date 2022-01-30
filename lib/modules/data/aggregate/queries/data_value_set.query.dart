import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataValueSetQuery extends BaseQuery<DataValueSet> {
  DataValueSetQuery({Database? database}) : super(database: database);
}

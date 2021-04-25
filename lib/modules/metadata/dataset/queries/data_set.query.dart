import 'package:dhis2_flutter_sdk/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataSetQuery extends BaseQuery<DataSet> {
  DataSetQuery({Database database}) : super(database: database);
}

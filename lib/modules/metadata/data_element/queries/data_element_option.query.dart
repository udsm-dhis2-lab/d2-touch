import 'package:dhis2_flutter_sdk/modules/metadata/data_element/entities/data_element_option.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataElementOptionQuery extends BaseQuery<DataElementOption> {
  DataElementOptionQuery({Database? database}) : super(database: database);
}

import 'package:dhis2_flutter_sdk/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataElementQuery extends BaseQuery<DataElement> {
  DataElementQuery({Database? database}) : super(database: database);
}

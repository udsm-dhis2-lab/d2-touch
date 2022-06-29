import 'package:d2_touch/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataElementQuery extends BaseQuery<DataElement> {
  DataElementQuery({Database? database}) : super(database: database);
}

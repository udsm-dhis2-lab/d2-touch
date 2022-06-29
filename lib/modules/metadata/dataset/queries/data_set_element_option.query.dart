import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/data_set_element_option.entity.dart';

class DataSetElementOptionQuery extends BaseQuery<DataSetElementOption> {
  DataSetElementOptionQuery({Database? database}) : super(database: database);
}

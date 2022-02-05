import 'package:dhis2_flutter_sdk/modules/metadata/option_set/entities/option.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class OptionQuery extends BaseQuery<Option> {
  OptionQuery({Database? database}) : super(database: database);
}

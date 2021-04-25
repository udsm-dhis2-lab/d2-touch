import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramQuery extends BaseQuery<Program> {
  ProgramQuery({Database database}) : super(database: database);
}

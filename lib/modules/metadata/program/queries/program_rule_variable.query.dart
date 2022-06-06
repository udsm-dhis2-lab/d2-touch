import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramRuleVariableQuery extends BaseQuery<ProgramRuleVariable> {
  ProgramRuleVariableQuery({Database? database}) : super(database: database);
}

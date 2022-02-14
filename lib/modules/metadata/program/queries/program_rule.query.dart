import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramRuleQuery extends BaseQuery<ProgramRule> {
  ProgramRuleQuery({Database? database}) : super(database: database);
}

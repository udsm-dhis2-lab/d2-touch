import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageSectionQuery extends BaseQuery<ProgramStageSection> {
  ProgramStageSectionQuery({Database? database}) : super(database: database);
}

import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageSectionQuery extends BaseQuery<ProgramStageSection> {
  ProgramStageSectionQuery({Database? database}) : super(database: database);
}

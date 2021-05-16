import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageQuery extends BaseQuery<ProgramStage> {
  ProgramStageQuery({Database database}) : super(database: database);
}

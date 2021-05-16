import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';

class ProgramModule {
  static createTables() async {
    await ProgramQuery().createTable();
    await ProgramStageQuery().createTable();
  }

  ProgramQuery program = ProgramQuery();

  ProgramStageQuery programStage = ProgramStageQuery();
}

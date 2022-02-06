import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';

class ProgramModule {
  static createTables() async {
    await ProgramQuery().createTable();
    await ProgramStageQuery().createTable();
    await ProgramTrackedEntityAttributeQuery().createTable();
  }

  ProgramQuery program = ProgramQuery();

  ProgramStageQuery programStage = ProgramStageQuery();

  ProgramTrackedEntityAttributeQuery get programTrackedEntityAttribute =>
      ProgramTrackedEntityAttributeQuery();
}

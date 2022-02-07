import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/attribute_option.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage_data_element.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage_section.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';

class ProgramModule {
  static createTables() async {
    await ProgramQuery().createTable();
    await ProgramStageQuery().createTable();
    await ProgramStageSectionQuery().createTable();
    await AttributeOptionQuery().createTable();
    await ProgramTrackedEntityAttributeQuery().createTable();
    await ProgramStageDataElementQuery().createTable();
  }

  ProgramQuery get program => ProgramQuery();

  ProgramStageQuery get programStage => ProgramStageQuery();

  ProgramTrackedEntityAttributeQuery get programTrackedEntityAttribute =>
      ProgramTrackedEntityAttributeQuery();

  AttributeOptionQuery get attributeOption => AttributeOptionQuery();

  ProgramStageSectionQuery get programStageSection =>
      ProgramStageSectionQuery();

  ProgramStageDataElementQuery get programStageDataElement =>
      ProgramStageDataElementQuery();
}

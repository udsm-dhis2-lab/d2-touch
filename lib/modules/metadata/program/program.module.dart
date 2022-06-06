import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/attribute_option.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_rule.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_rule_action.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_rule_variable.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage_data_element.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage_section.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';

import 'queries/program_stage_data_element_option.query.dart';

class ProgramModule {
  static createTables() async {
    await ProgramQuery().createTable();
    await ProgramStageQuery().createTable();
    await ProgramStageSectionQuery().createTable();
    await ProgramStageDataElementOptionQuery().createTable();
    await AttributeOptionQuery().createTable();
    await ProgramTrackedEntityAttributeQuery().createTable();
    await ProgramStageDataElementQuery().createTable();
    await ProgramRuleQuery().createTable();
    await ProgramRuleActionQuery().createTable();
    await ProgramRuleVariableQuery().createTable();
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

  ProgramStageDataElementOptionQuery get programStageDataElementOption =>
      ProgramStageDataElementOptionQuery();

  ProgramRuleQuery get programRule => ProgramRuleQuery();

  ProgramRuleActionQuery get programRuleAction => ProgramRuleActionQuery();

  ProgramRuleVariableQuery get programRuleVariable =>
      ProgramRuleVariableQuery();
}

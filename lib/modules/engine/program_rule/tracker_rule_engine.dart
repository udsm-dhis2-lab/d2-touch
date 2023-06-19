import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_attribute_value.query.dart';
import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_instance.query.dart';
import 'package:d2_touch/modules/engine/shared/utilities/data_value_entities.util.dart';
import 'package:d2_touch/modules/engine/program_rule/models/tracker_rule_result.model.dart';
import 'package:d2_touch/modules/engine/program_rule/utilities/program_rule_engine.util.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_variable.query.dart';
import 'package:queue/queue.dart';

class TrackerRuleEngine {
  static Future<TrackerRuleResult> execute(
      {required TrackedEntityInstance trackedEntityInstance,
      required String program,
      TrackedEntityAttributeValue? changedAttributeValue}) async {
    List<ProgramRule> programRules = await ProgramRuleQuery()
        .withActions()
        .where(attribute: 'program', value: program)
        .get();

    List<ProgramRuleVariable> programRuleVariables =
        await ProgramRuleVariableQuery()
            .where(attribute: 'program', value: program)
            .get();

    List<TrackedEntityAttributeValue> attributes =
        await TrackedEntityAttributeValueQuery()
            .where(
                attribute: 'trackedEntityInstance',
                value: trackedEntityInstance.trackedEntityInstance)
            .get();

    final dataValueEntities = DataValueEntities.fromAttributeValues(attributes);

    List<ProgramRuleAction> programRuleActions = ProgramRuleEngine.execute(
        dataValueEntities: dataValueEntities,
        programRules: programRules,
        programRuleVariables: programRuleVariables);

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    programRuleActions.forEach((programRuleAction) {
      if (programRuleAction.programRuleActionType == 'ASSIGN') {
        availableItemCount++;
        queue.add(() => TrackedEntityAttributeValueQuery()
            .setData(TrackedEntityAttributeValue(
                dirty: true,
                attribute: programRuleAction.trackedEntityAttribute as String,
                trackedEntityInstance:
                    trackedEntityInstance.trackedEntityInstance,
                value: programRuleAction.data.toString().replaceAll("\"", "")))
            .save());
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    TrackedEntityInstance updatedTrackedEntityInstance =
        await TrackedEntityInstanceQuery()
            .withAttributes()
            .withEnrollments()
            .byId(trackedEntityInstance.id as String)
            .getOne();

    return TrackerRuleResult(
        programRuleActions: programRuleActions,
        trackedEntityInstance: updatedTrackedEntityInstance);
  }

  List<ProgramRuleAction> forEvent(
      {TrackedEntityAttributeValue? attributeValue}) {
    return [];
  }
}

import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule_action.entity.dart';

class EventRuleResult {
  Event event;
  List<ProgramRuleAction> programRuleActions;
  EventRuleResult({required this.event, required this.programRuleActions});
}

class ProgramRuleEffect {
  final String id;
  final String location;
  final String action;
  final String dataElementId;
  final String trackedEntityAttributeId;
  final String programStageId;
  final String programStageSectionId;
  final String optionGroupId;
  final String optionId;
  final String content;
  final String data;
  final bool ineffect;

  ProgramRuleEffect(
      this.id,
      this.location,
      this.action,
      this.dataElementId,
      this.trackedEntityAttributeId,
      this.programStageId,
      this.programStageSectionId,
      this.optionGroupId,
      this.optionId,
      this.content,
      this.data,
      this.ineffect);
}

class ProgramRuleAction {
  final String created;
  final String lastUpdated;
  final String id;
  final String programRuleActionType;
  final String data;
  final dynamic lastUpdatedBy;
  final dynamic trackedEntityAttribute;
  final dynamic programRule;
  final dynamic dataElement;
  final String content;
  final dynamic optionGroup;
  final String templateUid;
  final String location;
  final dynamic programStageSection;
  final dynamic programStage;

  ProgramRuleAction(
      this.created,
      this.lastUpdated,
      this.id,
      this.programRuleActionType,
      this.data,
      this.lastUpdatedBy,
      this.trackedEntityAttribute,
      this.programRule,
      this.dataElement,
      this.content,
      this.optionGroup,
      this.templateUid,
      this.location,
      this.programStageSection,
      this.programStage);
}

enum ProgramRuleActionType {
  Assign,
  Displaykeyvaluepair,
  Displaytext,
  Hidefield,
  Hideoptiongroup,
  Hideprogramstage,
  Hidesection,
  Schedulemessage,
  Sendmessage,
  Showerror,
  Showwarning,
  Warningoncomplete
}

class UserModel {
  final String id;
  UserModel(this.id);
}

class ProgramStage {
  final String id;
  ProgramStage(this.id);
}

class Program {
  final String id;
  Program(this.id);
}

class ProgramRule {
  final String created;
  final String lastUpdated;
  final String name;
  final String id;
  final String description;
  num priority;
  final String condition;
  final UserModel lastUpdatedBy;
  final ProgramStage programStage;
  final Program program;
  final List<ProgramRuleAction> programRuleActions;

  ProgramRule(
      this.created,
      this.lastUpdated,
      this.name,
      this.id,
      this.description,
      this.priority,
      this.condition,
      this.lastUpdatedBy,
      this.programStage,
      this.program,
      this.programRuleActions);
}

class ProgramRuleVariable {
  final String id;
  final String programRuleVariableSourceType;
  final dynamic dataElement;
  final dynamic trackedEntityAttribute;
  final dynamic programStage;
  final bool useNameForOptionSet;
  final String name;
  final bool useCodeForOptionSet;
  final dynamic lastUpdatedBy;
  final dynamic program;

  ProgramRuleVariable(
      this.id,
      this.programRuleVariableSourceType,
      this.dataElement,
      this.trackedEntityAttribute,
      this.programStage,
      this.useNameForOptionSet,
      this.name,
      this.useCodeForOptionSet,
      this.lastUpdatedBy,
      this.program);
}

class Option {
  final String code;
  final String displayName;
  final String id;

  Option(this.code, this.displayName, this.id);
}

class OptionSet {
  final String id;
  final String displayName;
  final List<Option> options;

  OptionSet(this.id, this.displayName, this.options);
}

class OptionSets {}

class PRuleConstant {
  String id;
  String displayName;
  dynamic value;

  PRuleConstant(this.id, this.displayName, this.value);
}

class ProgramRulesContainer {
  final List<ProgramRuleVariable> programRulesVariables;
  final List<ProgramRule> programRules;
  final List<PRuleConstant> constants;
  ProgramRulesContainer(
      this.programRulesVariables, this.programRules, this.constants);
}

class EventMain {
  final String event;
  final String program;
  final String programStage;
  final String orgUnit;
  final String orgUnitName;
  final String trackedEntityInstance;
  final String enrollment;
  final String enrollmentStatus;
  final String status;
  final String eventDate;
  final String dueDate;
  final List<EventValue> dataValues;

  EventMain(
      this.event,
      this.program,
      this.programStage,
      this.orgUnit,
      this.orgUnitName,
      this.trackedEntityInstance,
      this.enrollment,
      this.enrollmentStatus,
      this.status,
      this.eventDate,
      this.dueDate,
      this.dataValues);
}

class EventValue {
  final String dataElement;
  final String value;

  EventValue(this.dataElement, this.value);

  @override
  String toString() {
    return '{ ${this.dataElement}, ${this.value} }';
  }
}

class EventData {
  final String event;
  final String program;
  final String programStage;
  final String orgUnit;
  final String trackedEntityInstance;
  final String enrollment;
  final String status;
  final String eventDate;
  final String dueDate;
  final List<EventValue> dataValues;

  EventData(
      this.event,
      this.program,
      this.programStage,
      this.orgUnit,
      this.trackedEntityInstance,
      this.enrollment,
      this.status,
      this.eventDate,
      this.dueDate,
      this.dataValues);
}

class EventValues {
  EventValues();
}

class EventsDataContainer {
  List<EventData> all;
  Map<String, dynamic> byStage;

  EventsDataContainer(this.all, this.byStage);
}

class DataElement {
  final String id;
  final String valueType;
  final String optionSetId;

  DataElement(this.id, this.valueType, this.optionSetId);
}

class DataElements {
  DataElements();
}

class TrackedEntityAttribute {
  String id;
  String valueType;
  String optionSetId;

  TrackedEntityAttribute(this.id, this.valueType, this.optionSetId);
}

class TrackedEntityAttributes {
  TrackedEntityAttributes();
}

class Enrollment {
  final String enrollmentDate;
  final String incidentDate;
  final String enrollmentId;

  Enrollment(this.enrollmentDate, this.incidentDate, this.enrollmentId);
}

class TEIValues {
  TEIValues();
}

class OrgUnit {
  String id;
  String code;

  OrgUnit(this.id, this.code);
}

class DateUtils {
  dynamic /* () => string */ getToday;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ daysBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ weeksBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ monthsBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ yearsBetween;
  dynamic /* (rulesDate: string, daysToAdd: string) => string */ addDays;
}

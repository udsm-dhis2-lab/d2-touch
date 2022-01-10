// @flow
abstract class ProgramRuleEffect {
  String id;
  String location;
  String action;
  String dataElementId;
  String trackedEntityAttributeId;
  String programStageId;
  String programStageSectionId;
  String optionGroupId;
  String optionId;
  String content;
  String data;
  bool ineffect;
}

abstract class ProgramRuleAction {
  String created;
  String lastUpdated;
  String id;
  String programRuleActionType;
  String data;
  dynamic lastUpdatedBy;
  dynamic trackedEntityAttribute;
  dynamic programRule;
  dynamic dataElement;
  String content;
  dynamic optionGroup;
  String templateUid;
  String location;
  dynamic programStageSection;
  dynamic programStage;
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

abstract class User {
  String id;
}

abstract class ProgramStage {
  String id;
}

abstract class Program {
  String id;
}

abstract class ProgramRule {
  String created;
  String lastUpdated;
  String name;
  String id;
  String description;
  num priority;
  String condition;
  User lastUpdatedBy;
  ProgramStage programStage;
  Program program;
  List<ProgramRuleAction> programRuleActions;
}

abstract class ProgramRuleVariable {
  String id;
  String programRuleVariableSourceType;
  dynamic dataElement;
  dynamic trackedEntityAttribute;
  dynamic programStage;
  bool useNameForOptionSet;
  String name;
  bool useCodeForOptionSet;
  dynamic lastUpdatedBy;
  dynamic program;
}

abstract class Option {
  String code;
  String displayName;
  String id;
}

abstract class OptionSet {
  String id;
  String displayName;
  List<Option> options;
}

abstract class OptionSets {}

abstract class Constant {
  String id;
  String displayName;
  dynamic value;
}

abstract class ProgramRulesContainer {
  Array<ProgramRuleVariable> programRulesVariables;
  Array<ProgramRule> programRules;
  List<Constant> constants;
}

abstract class EventMain {
  String event;
  String program;
  String programStage;
  String orgUnit;
  String orgUnitName;
  String trackedEntityInstance;
  String enrollment;
  String enrollmentStatus;
  String status;
  String eventDate;
  String dueDate;
  List<EventValue> dataValues;
}

abstract class EventValue {
  String dataElement;
  String value;
}

abstract class EventValues {}

abstract class EventsDataContainer {
  List<EventData> all;
  Map<String, List<EventData>> byStage;
}

abstract class DataElement {
  String id;
  String valueType;
  String optionSetId;
}

abstract class DataElements {}

abstract class TrackedEntityAttribute {
  String id;
  String valueType;
  String optionSetId;
}

abstract class TrackedEntityAttributes {}

abstract class Enrollment {
  String enrollmentDate;
  String incidentDate;
  String enrollmentId;
}

abstract class TEIValues {}

abstract class OrgUnit {
  String id;
  String code;
}

abstract class DateUtils {
  dynamic /* () => string */ getToday;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ daysBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ weeksBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ monthsBetween;
  dynamic /* (firstRulesDate: string, secondRulesDate: string) => string */ yearsBetween;
  dynamic /* (rulesDate: string, daysToAdd: string) => string */ addDays;
}

abstract class IMomentConverter {
  Moment rulesDateToMoment(String rulesEngineValue);
  String momentToRulesDate(Moment momentValue);
}

abstract class IConvertInputRulesValue {
  String convertText(dynamic value);
  String convertLongText(dynamic value);
  String convertLetter(dynamic value);
  String convertPhoneNumber(dynamic value);
  String convertEmail(dynamic value);
  dynamic /* bool | String */ convertBoolean(dynamic value);
  dynamic /* bool | String */ convertTrueOnly(dynamic value);
  String convertDate(dynamic value);
  String convertDateTime(dynamic value);
  String convertTime(dynamic value);
  dynamic /* num | String */ convertNumber(dynamic value);
  dynamic /* num | String */ convertInteger(dynamic value);
  dynamic /* num | String */ convertIntegerPositive(dynamic value);
  dynamic /* num | String */ convertIntegerNegative(dynamic value);
  dynamic /* num | String */ convertIntegerZeroOrPositive(dynamic value);
  dynamic /* num | String */ convertPercentage(dynamic value);
  String convertUrl(dynamic value);
  dynamic /* num | String */ convertAge(dynamic value);
}

import '../utilities/variables.dart';

class ProgramRuleExecution {
  dynamic executeProgramRule(
      Map<String, Object> eventData,
      Map<String, Object> dataElements,
      List<Map<String, Object>> programRules,
      List<Map<String, Object>> programRuleVariables,
      List<Map<String, Object>> optionSets) {
    final List dataValues = eventData.containsKey('dataValues')
        ? eventData['dataValues'] as List
        : [];
    final keyValuePairedDataValues = Map.fromIterable(dataValues,
        key: (e) => e['dataElement'], value: (e) => e['value']);
    final transformedData = {
      ...eventData,
      'dataValues': keyValuePairedDataValues
    };

    final executionResults = ruleExecution(transformedData, dataElements,
        programRules, programRuleVariables, optionSets);
    print(executionResults);
    return dataValues;
  }

  dynamic ruleExecution(
      Map<String, Object> eventData,
      Map<String, Object> dataElements,
      List<Map<String, Object>> programRules,
      List<Map<String, Object>> programRuleVariables,
      List<Map<String, Object>> optionSets) {
    final bool programRulesExist = programRules.length > 0;
    if (!programRulesExist) {
      return eventData;
    }

    final List orderedProgramRules = programRules;
    // print(orderedProgramRules);

    // print(eventData['dataValues']);
    final dynamic variables = VariablesUtil.getVariables(eventData, programRules, programRuleVariables, dataElements, optionSets);
    return 'done';
  }

  List orderProgramRulesByPriority(programRules) {
    return programRules.sort((a, b) =>
        a.containsKey('priority') && b.containsKey('priority')
            ? (a['priority'] as int).compareTo(b['priority'] as int)
            : -1);
  }
}

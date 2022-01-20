

import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/engines/program_rule/constants/types_keys.constant.dart';
import 'package:dhis2_flutter_sdk/modules/engines/program_rule/constants/variable_prefix.constant.dart';


abstract class VariablesUtil {

  static getVariables(
          Map<String, Object> eventData,
          List<Map<String, Object>> programRules,
          List<Map<String, Object>> programRuleVariables,
          Map<String, Object> dataElements,
          List<Map<String, Object>> optionSets
      ) {
    dynamic variables = programRuleVariables.map((dynamic programRuleVariable) {
      print(programRuleVariable);
      dynamic variable = null;
      dynamic keyedVariablesByVariableName = null;
      final String programRuleVariableSourceType = programRuleVariable['programRuleVariableSourceType'];
      final String variableKey = programRuleVariable['name'];
      final dynamic variableSourceTypesDataElementSpecific = VariablesUtil.VariableSourceTypesDataElementSpecific();
      if (variableSourceTypesDataElementSpecific == programRuleVariableSourceType) {
        variable = preCheckDataElement(programRuleVariable, dataElements);
      }

      keyedVariablesByVariableName = 'Key: $variableKey, Value: $variable';

      if (variable) {
        return keyedVariablesByVariableName;
      }
      return keyedVariablesByVariableName;
    });

    print(variables);
    return  variables;
  }

  static preCheckDataElement(dynamic programRuleVariable, Map<String, Object> dataElements) {
    final dynamic dataElementId = programRuleVariable['dataElement'] != null ?  programRuleVariable['dataElement']:  programRuleVariable['dataElement']['id'];
    final dynamic dataElement =
        dataElementId && dataElements.length > 0 && dataElements[dataElementId] != null;
    if (dataElement != null) {
      const EMPTY_STRING = '';
      final dynamic typeKeys = ProgramRulesConstants.typeKeys();
      final dynamic variablePrefixes = VariablePrefixesConstants.prefixes();
      return buildVariable(
          EMPTY_STRING,
          null,
          typeKeys['TEXT'],
          false,
          variablePrefixes['DATAELEMENT'],
          null,
          programRuleVariable['useNameForOptionSet']
      );
    }
    return null;
  }


  static postCheckDataElement(dynamic programRuleVariable, Map<String, Object> dataElements) {
    final dynamic dataElementId = programRuleVariable['dataElement'] != null ?  programRuleVariable['dataElement']:  programRuleVariable['dataElement']['id'];
    final dynamic dataElement =
        dataElementId && dataElements.length > 0 && dataElements[dataElementId] != null;
    const EMPTY_STRING = '';
    final dynamic typeKeys = ProgramRulesConstants.typeKeys();
    final dynamic variablePrefixes = VariablePrefixesConstants.prefixes();
        return buildVariable(
            EMPTY_STRING,
            null,
            typeKeys['TEXT'],
            false,
            variablePrefixes['DATAELEMENT'],
            null,
            programRuleVariable['useNameForOptionSet']
        );
  }

  static buildVariable(value, allValues, String type, bool valueFound, variablePrefix,variableEventDate,useNameForOptionSet) {
    return value;
  }

  static VariableSourceTypesDataElementSpecific() {
    return 'DATAELEMENT_CURRENT_EVENT';
    }
}
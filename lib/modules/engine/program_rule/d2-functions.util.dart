import 'package:d2_touch/modules/engine/program_rule/utilities/date.utils.dart';
import 'package:d2_touch/modules/engine/program_rule/utilities/rules-engine.util.dart';
import 'package:d2_touch/modules/engine/program_rule/utilities/trim-quotes.utils.dart';

List<Map<String, dynamic>> d2FuctionsVariables = [
  {"name": "d2:daysBetween", "parameters": 2},
  {"name": "d2:weeksBetween", "parameters": 2},
  {"name": "d2:monthsBetween", "parameters": 2},
  {"name": "d2:yearsBetween", "parameters": 2},
  {"name": "d2:floor", "parameters": 1},
  {"name": "d2:modulus", "parameters": 2},
  {"name": "d2:concatenate"},
  {"name": "d2:addDays", "parameters": 2},
  {"name": "d2:zing", "parameters": 1},
  {"name": "d2:oizp", "parameters": 1},
  {"name": "d2:count", "parameters": 1},
  {"name": "d2:countIfZeroPos", "parameters": 1},
  {"name": "d2:countIfValue", "parameters": 2},
  {"name": "d2:ceil", "parameters": 1},
  {"name": "d2:round", "parameters": 1},
  {"name": "d2:hasValue", "parameters": 1},
  {"name": "d2:lastEventDate", "parameters": 1},
  {"name": "d2:validatePattern", "parameters": 2},
  {"name": "d2:addControlDigits", "parameters": 1},
  {"name": "d2:checkControlDigits", "parameters": 1},
  {"name": "d2:left", "parameters": 2},
  {"name": "d2:right", "parameters": 2},
  {"name": "d2:substring", "parameters": 3},
  {"name": "d2:split", "parameters": 3},
  {"name": "d2:zScoreWFA", "parameters": 3},
  {"name": "d2:length", "parameters": 1},
];

Map<String, Function> d2FunctionsEval = {
  'd2:hasValue': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final variableName = parameters[0];
    final variableObject = variableHash[variableName];

    var valueFound = false;

    if (variableObject != null) {
      if (variableObject['hasValue']) {
        valueFound = true;
      }
    } else {
      // log.warn('could not find variable to check if has value: ' + variableName);
    }
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, valueFound.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:daysBetween': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date1 = parameters[0];
    final date2 = parameters[1];

    final daysBetween = DateUtils.daysBetween(date1, date2);
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, daysBetween.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:weeksBetween': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date1 = parameters[0];
    final date2 = parameters[1];
    final weeksBetween = DateUtils.weeksBetween(date1, date2);
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, weeksBetween.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:monthsBetween': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date1 = parameters[0];
    final date2 = parameters[1];
    final monthsBetween = DateUtils.monthsBetween(date1, date2);
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, monthsBetween.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:yearsBetween': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date1 = parameters[0];
    final date2 = parameters[1];
    final yearsBetween = DateUtils.yearsBetween(date1, date2);
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, yearsBetween.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:floor': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date1 = parameters[0];
    final floored = date1.floor();
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, floored.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:modulus': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final dividend = parameters[0];
    final divisor = parameters[1];
    final rest = int.parse(dividend) % int.parse(divisor);
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, rest.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:concatenate': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    var returnString = "'";
    for (var i = 0; i < parameters.length; i++) {
      returnString += parameters[i];
    }

    returnString += "'";
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, returnString);
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:addDays': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final date = parameters[0];
    final daysToAdd = parameters[1];
    final newDate = DateUtils.addDays(date, daysToAdd);
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, newDate.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:zing': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final numBer = parameters[0] < 0 ? 0 : parameters[0];
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, numBer.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:oizp': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final numBer = parameters[0] < 0 ? 0 : 1;
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, numBer.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:count': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final variableName = parameters[0];
    final variableObject = variableHash[variableName];
    final count = variableObject != null &&
            variableObject['hasValue'] &&
            variableObject['allValues'] != null
        ? variableObject['allValues'].length
        : 0;
    if (variableObject == null) {
      // log.warn('could not find variable to count: ' + variableName);
    }
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, count.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:countIfZeroPos': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final variableName = trimQuotes(parameters[0]);
    final variableObject = variableHash[variableName];
    var count = 0;
    if (variableObject != null) {
      if (variableObject['hasValue']) {
        if (variableObject['allValues'] != null &&
            variableObject['allValues'].length > 0) {
          for (var i = 0; i < variableObject['allValues'].length; i++) {
            if (variableObject['allValues'][i] >= 0) {
              count++;
            }
          }
        } else {
          // The variable has a value, but no list of alternates. This means we only compare the element's real value
          if (variableObject['variableValue'] >= 0) {
            count = 1;
          }
        }
      }
    } else {
      // log.warn('could not find variable to countifzeropos: ' + variableName);
    }
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, count.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:countIfValue': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    final variableName = trimQuotes(parameters[0]);
    final variableObject = variableHash[variableName];
    final valueToCompare = processValue(
      parameters[1],
      variableObject['variableType'],
    );
    var count = 0;
    if (variableObject != null) {
      if (variableObject['hasValue']) {
        if (variableObject['allValues'] != null &&
            variableObject['allValues'].length > 0) {
          for (var i = 0; i < variableObject['allValues'].length; i++) {
            if (valueToCompare == variableObject['allValues'][i]) {
              count++;
            }
          }
        } else {
          // The variable has a value, but no list of alternates. This means we only compare the element's real value
          if (variableObject['variableValue'] >= 0) {
            count = 1;
          }
        }
      }
    } else {
      // log.warn('could not find variable to countifzeropos: ' + variableName);
    }
    // Replace the end evaluation of the dhis function:
    final newExpression = expression.replaceAll(regexFunct, count.toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:ceil': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, parameters[0].ceil().toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  },
  'd2:round': (
    expression,
    parameters,
    variableHash,
    regexFunct,
  ) {
    // Replace the end evaluation of the dhis function:
    final newExpression =
        expression.replaceAll(regexFunct, parameters[0].round().toString());
    final expressionUpdated = true;
    return {
      'expression': newExpression,
      'expressionUpdated': expressionUpdated
    };
  }
};

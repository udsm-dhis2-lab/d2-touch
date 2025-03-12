import 'package:d2_touch/modules/engine/program_rule/utilities/date.utils.dart';

final List<Map<String, dynamic>> d2FunctionsVariables = [
  {'name': 'd2:daysBetween', 'parameters': 2},
  {'name': 'd2:weeksBetween', 'parameters': 2},
  {'name': 'd2:monthsBetween', 'parameters': 2},
  {'name': 'd2:yearsBetween', 'parameters': 2},
  {'name': 'd2:floor', 'parameters': 1},
  {'name': 'd2:modulus', 'parameters': 2},
  {'name': 'd2:concatenate', 'parameters': 0},
  {'name': 'd2:addDays', 'parameters': 2},
  {'name': 'd2:zing', 'parameters': 1},
  {'name': 'd2:oizp', 'parameters': 1},
  {'name': 'd2:count', 'parameters': 1},
  {'name': 'd2:countIfZeroPos', 'parameters': 1},
  {'name': 'd2:countIfValue', 'parameters': 2},
  {'name': 'd2:ceil', 'parameters': 1},
  {'name': 'd2:round', 'parameters': 1},
  {'name': 'd2:hasValue', 'parameters': 1},
  {'name': 'd2:lastEventDate', 'parameters': 1},
  {'name': 'd2:validatePattern', 'parameters': 2},
  {'name': 'd2:addControlDigits', 'parameters': 1},
  {'name': 'd2:checkControlDigits', 'parameters': 1},
  {'name': 'd2:left', 'parameters': 2},
  {'name': 'd2:right', 'parameters': 2},
  {'name': 'd2:substring', 'parameters': 3},
  {'name': 'd2:split', 'parameters': 3},
  {'name': 'd2:zScoreWFA', 'parameters': 3},
  {'name': 'd2:length', 'parameters': 1},
];

bool toBoolean(String str, [bool strict = false]) {
  if (strict == true) {
    return str == '1' || str == 'true';
  }
  return str != '0' && str != 'false' && str != '';
}

class D2FunctionUtil {
  static String hasValue(dynamic value) {
    if (value == null || value.toString().isEmpty) {
      return '0 == 1';
    }

    return '1 == 1';
  }

  static String validatePattern(String regex, String value) {
    print('ASSIGN DATA $regex $value');
    try {
      RegExp pattern = RegExp(regex);
      final isValid = pattern.hasMatch(value);
      return isValid ? '1 == 1' : '0 == 1';
    } catch (e) {
      return '0 == 1';
    }
  }

  static String length(dynamic value) {
    if (value == null) {
      return '0';
    }

    return value.length.toString();
  }

  static String left(dynamic value, int numberOfCharacters) {
    if (value == null) {
      return '';
    }

    return value.toString().substring(0, numberOfCharacters);
  }

  static String right(dynamic value, int numberOfCharacters) {
    if (value == null) {
      return '';
    }

    final int valueLength = value.toString().length;

    return value
        .toString()
        .substring(valueLength - numberOfCharacters - 1, valueLength - 1);
  }

  static String concatenate(List<String> parametes) {
    return parametes.join(',');
  }
}

final Map<String, Function> d2FunctionsEval = {
  'd2:hasValue': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final value = parameters.isNotEmpty ? parameters.first : null;
    final valueFound = value != null || value == 0 || !toBoolean(value);
    return _replaceExpression(expression, regexFunct, valueFound);
  },
  'd2:daysBetween': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final daysBetween = DateUtils.daysBetween(parameters[0], parameters[1]);
    return _replaceExpression(expression, regexFunct, daysBetween);
  },
  'd2:weeksBetween': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final weeksBetween = DateUtils.weeksBetween(parameters[0], parameters[1]);
    return _replaceExpression(expression, regexFunct, weeksBetween);
  },
  'd2:monthsBetween': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final monthsBetween = DateUtils.monthsBetween(parameters[0], parameters[1]);
    return _replaceExpression(expression, regexFunct, monthsBetween);
  },
  'd2:yearsBetween': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final yearsBetween = DateUtils.yearsBetween(parameters[0], parameters[1]);
    return _replaceExpression(expression, regexFunct, yearsBetween);
  },
  'd2:floor': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final floored = parameters.isNotEmpty ? parameters.first.floor() : 0;
    return _replaceExpression(expression, regexFunct, floored);
  },
  'd2:modulus': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final rest = parameters.length == 2 ? parameters[0] % parameters[1] : 0;
    return _replaceExpression(expression, regexFunct, rest);
  },
  'd2:concatenate': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final returnString = "'" + parameters.join() + "'";
    return _replaceExpression(expression, regexFunct, returnString);
  },
  // 'd2:addDays': (String expression, List<dynamic> parameters,
  //     Map<String, dynamic> variableHash, String regexFunct) {
  //   final newDate = DateUtils.addDays(parameters[0], parameters[1]);
  //   return _replaceExpression(expression, regexFunct, newDate);
  // },
  'd2:zing': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final number = parameters.first < 0 ? 0 : parameters.first;
    return _replaceExpression(expression, regexFunct, number);
  },
  'd2:oizp': (String expression, List<dynamic> parameters,
      Map<String, dynamic> variableHash, String regexFunct) {
    final number = parameters.first < 0 ? 0 : 1;
    return _replaceExpression(expression, regexFunct, number);
  },
};

Map<String, dynamic> _replaceExpression(
    String expression, String regexFunct, dynamic value) {
  final newExpression =
      expression.replaceAll(RegExp(regexFunct), value.toString());
  return {'expression': newExpression, 'expressionUpdated': true};
}

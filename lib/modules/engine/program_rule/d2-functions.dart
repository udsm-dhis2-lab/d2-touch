// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/modules/engine/program_rule/utilities/d2-functions.util.dart';
import 'package:d2_touch/modules/engine/program_rule/utilities/date.utils.dart';

String d2Functions(String expression) {
  String evalExpression = expression;
  if (evalExpression.contains('d2:')) {
    bool continueLooping = true;

    for (int i = 0; i < 1 && continueLooping; i++) {
      bool brokenExecution = false;

      for (var d2FnVar in d2FunctionsVariables) {
        RegExp d2FnRegex = RegExp(
          '${d2FnVar['name']}\\( *(([\\d/\\*\\+\\-%. ]+)|( *\'[^\']*\'))*( *, *(([\\d/\\*\\+\\-%. ]+)|\'[^\']*\'))* *\\)',
          caseSensitive: false,
        );

        Iterable<RegExpMatch> fnRegexCallArr =
            d2FnRegex.allMatches(evalExpression);

        for (var match in fnRegexCallArr) {
          String fnRegexCall = match.group(0) ?? '';
          String fnParameters =
              fnRegexCall.replaceAll(RegExp(r'(^[^\(]+\()|\)$'), '').trim();
          List<String> parameters =
              RegExp(r"(?<=^|,)\s*(?:'([^']*)'|(\d+\.?\d*)\b|(true|false))\s*")
                  .allMatches(fnParameters)
                  .map((m) => m.group(0) ?? '')
                  .toList();

          /**
           * Check if parameters provided match what is expected in the function to run
           */
          int numOfParameters = parameters.length;
          if (numOfParameters != d2FnVar['parameters']) {
            brokenExecution = true;
          }

          if (brokenExecution) {
            evalExpression = evalExpression.replaceAll(fnRegexCall, '1 == 0');
          } else {
            var results = runD2Function(d2FnVar['name'], parameters);

            if (results.isNotEmpty) {
              evalExpression = evalExpression.replaceAll(fnRegexCall, results);
            }
          }
        }
      }

      continueLooping = evalExpression.contains('d2:');
    }
  }

  return evalExpression;
}

String runD2Function(String functionName, List<String> parameters) {
  switch (functionName) {
    case 'd2:hasValue':
      return '(${D2FunctionUtil.hasValue(parameters[0])})';
    case 'd2:validatePattern':
      return '(${D2FunctionUtil.validatePattern(parameters[1], parameters[0])})';
    case 'd2:daysBetween':
      return DateUtils.daysBetween(parameters[0], parameters[1]).toString();
    case 'd2:yearsBetween':
      return DateUtils.yearsBetween(parameters[0], parameters[1]).toString();
    case 'd2:monthsBetween':
      return DateUtils.monthsBetween(parameters[0], parameters[1]).toString();
    case 'd2:length':
      return D2FunctionUtil.length(parameters[0]);

    default:
      return '';
  }
}

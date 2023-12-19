import 'package:d2_touch/modules/engine/program_rule/d2-functions.util.dart';
import 'package:d2_touch/modules/engine/program_rule/d2.util.dart';
import 'package:expressions/expressions.dart';

String dhisD2Functions(String expression, Map<String, Variable> variableHash) {
  String evalExpression = expression;

  if (isDefined(evalExpression) && evalExpression.contains('d2:')) {
    bool continueLooping = true;

    for (int i = 0; i < 10 && continueLooping; i++) {
      bool expressionUpdated = false;
      bool brokenExecution = false;

      d2FuctionsVariables.forEach((d2FnVar) {
        RegExp d2FnRegex = RegExp(
          '${d2FnVar['name']}\\(((\\d[\\d/\\*\\+\\-%. ]+)|(\'[^\']*\'))( *, (\\d[\\d/\\*\\+\\-%. ]+)|(\'[^\']*\'))*\\)',
          caseSensitive: false,
        );

        Iterable<Match> fnRegexCallArr = d2FnRegex.allMatches(evalExpression);

        if (fnRegexCallArr.isNotEmpty) {
          fnRegexCallArr.forEach((fnRegexCall) {
            String fnParameters = fnRegexCall
                .group(0)!
                .replaceAll(RegExp('(^[^\\(]+\\()|\\)\$'), '')
                .trim();

            List<String?>? parameters = fnParameters.split(',');

            if (isDefined(d2FnVar['parameters'])) {
              int numOfParameters = parameters.length;
              if (numOfParameters != d2FnVar['parameters']) {
                brokenExecution = true;
              }
            }

            if (!brokenExecution && isDefined(parameters)) {
              for (int i = 0; i < parameters.length; i++) {
                parameters[i] = runRuleExpression(
                  parameters[i] ?? '',
                  d2FnVar['name'],
                  'parameter:$i',
                  variableHash,
                ) as String?;
              }
            }

            if (brokenExecution) {
              evalExpression =
                  evalExpression.replaceFirst(fnRegexCall.group(0)!, 'false');
              expressionUpdated = true;
            }

            Map<String, dynamic> results = d2FunctionsEval[d2FnVar['name']]!(
              evalExpression,
              parameters,
              variableHash,
              fnRegexCall.group(0)!,
            );

            evalExpression = results['expression'];
            expressionUpdated = results['expressionUpdated'];
          });
        }
      });

      if (expressionUpdated && evalExpression.contains('d2:')) {
        continueLooping = true;
      } else {
        continueLooping = false;
      }
    }
  }

  return evalExpression;
}

bool runRuleExpression(String expression, String beforeReplacement,
    String identifier, Map<String, Variable> variablesHash) {
  try {
    dynamic canEvalRule = dhisD2Functions(expression, variablesHash);

    return canEvalRule;
  } catch (e) {
    return false;
  }
}

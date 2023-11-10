import 'package:d2_touch/modules/engine/program_rule/d2-functions.util.dart';
import 'package:d2_touch/modules/engine/program_rule/d2.util.dart';
import 'package:expressions/expressions.dart';


String dhisD2Functions(String expression, Map<String, Variable> variableHash) {
  String evalExpression = expression;
  if (isDefined(evalExpression) && evalExpression.contains('d2:')) {
    bool continueLooping = true;
    // Safety harness on 10 loops, in case of unanticipated syntax causing unintended looping
    for (int i = 0; i < 10 && continueLooping; i++) {
      bool expressionUpdated = false;
      bool brokenExecution = false;

      d2FuctionsVariables.forEach((d2FnVar) {
        // Select the function call, with any number of parameters inside single quotations, or number parameters without quotations
        RegExp d2FnRegex = RegExp(
          d2FnVar['name'] +
              "\\( *(([\\d/\\*\\+\\-%. ]+)|( *'[^']*'))*( *, *(([\\d/\\*\\+\\-%. ]+)|'[^']*'))* *\\)",
          caseSensitive: false,
        );
        Iterable<Match> fnRegexCallArr = d2FnRegex.allMatches(evalExpression);

        if (fnRegexCallArr.isNotEmpty) {
          fnRegexCallArr.forEach((fnRegexCall) {
            // Remove the function name and parentheses and remove whitespaces:
            String fnParameters = fnRegexCall
                .group(0)!
                .replaceAll(RegExp('(^[^\\(]+\\()|\\)\$'), '')
                .trim();

            // Split into single parameters:
            List<String?>? parameters = fnParameters.split(',');

            // Check if it has parameters and match the required parameters
            if (isDefined(d2FnVar['parameters'])) {
              // But we are only checking parameters where the dhisFunction actually has a defined set of parameters (concatenate, for example, does not have a fixed number);
              int numOfParameters = parameters?.length ?? 0;
              if (numOfParameters != d2FnVar['parameters']) {
                // log.warn(d2FnVar.name + ' was called with the incorrect number of parameters');

                // Mark this function call as broken:
                brokenExecution = true;
              }
            }

            // In case the function call is nested, the parameter itself contains an expression, run the expression.
            if (!brokenExecution && isDefined(parameters)) {
              for (int i = 0; i < parameters.length; i++) {
                // parameters[i] = runRuleExpression(
                //   parameters[i]!,
                //   d2FnVar['name']!,
                //   'parameter:$i',
                //   variableHash,
                // );
              }
            }

            // Special block for d2:weeksBetween(*,*) - add such a block for all other dhis functions.
            if (brokenExecution) {
              // Function call is not possible to evaluate, remove the call:
              evalExpression = evalExpression.replaceFirst(fnRegexCall.group(0)!, 'false');
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
      // We only want to continue looping until we made a successful replacement,
      // and there is still occurrences of "d2:" in the code. In cases where d2: occurs outside
      // the expected d2: function calls, one unnecessary iteration will be done and the
      // successfulExecution will be false coming back here, ending the loop. The last iteration
      // should be zero to marginal performance-wise.
      if (expressionUpdated && evalExpression.contains('d2:')) {
        continueLooping = true;
      } else {
        continueLooping = false;
      }
    }
  }

  return evalExpression;
}


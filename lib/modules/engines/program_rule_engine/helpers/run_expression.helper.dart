// @flow
import "package:loglevel.dart" as log;
import "d2_functions.helper.dart" show d2FuctionsVariables, d2FunctionsEval;
import "d2_utils.helper.dart" show isDefined;
import "../interfaces/rules-engine.types.dart" show Variable;

final dhisD2Functions = /* String */ (String expression,
    Map<String, Variable> variableHash) {
  var evalExpression = expression;
  if (isDefined && evalExpression.includes("d2:")) {
    var continueLooping = true;
    //Safety harness on 10 loops, in case of unanticipated syntax causing unintencontinued looping
    for (var i = 0; i < 1 && continueLooping; i++) {
      var expressionUpdated = false;
      var brokenExecution = false;
      d2FuctionsVariables.forEach((d2FnVar) {
        //Select the function call, with any number of parameters inside single quotations, or number parameters witout quotations
        var d2FnRegex = new RegExp(
            d2FnVar.name +
                "\\( *(([\\d/\\*\\+\\-%. ]+)|( *'[^']*'))*( *, *(([\\d/\\*\\+\\-%. ]+)|'[^']*'))* *\\)",
            "g");
        var fnRegexCallArr = evalExpression.match(d2FnRegex);
        if (fnRegexCallArr && fnRegexCallArr.length) {
          fnRegexCallArr.forEach((fnRegexCall) {
            // Remove the function name and paranthesis and remove whitespaces:
            final fnParameters =
                fnRegexCall.replace(new RegExp(r'(^[^\(]+\()|\)$'), "").trim();
            // Split into single parameters:
            final parameters = fnParameters.match(new RegExp(
                r'((' + "'" + r'[^' + "'" + r']+' + "'" + r')|([^,]+))'));
            // Check if it has parameters and match the required parameters
            if (isDefined(d2FnVar.parameters)) {
              //But we are only checking parameters where the dhisFunction actually has a defined set of parameters(concatenate, for example, does not have a fixed number);
              final numOfParameters = parameters ? parameters.length : 0;
              if (!identical(numOfParameters, d2FnVar.parameters)) {
                // log.warn(d2FnVar.name + ' was called with the incorrect number of parameters');

                //Mark this function call as broken:
                brokenExecution = true;
              }
            }
            //In case the function call is nested, the parameter itself contains an expression, run the expression.
            if (!brokenExecution &&
                isDefined(parameters) &&
                !identical(parameters, null)) {
              for (var i = 0; i < parameters.length; i++) {
                parameters[i] = runRuleExpression(parameters[i], d2FnVar.name,
                    '''parameter:${ i}''', variableHash);
              }
            }
            //Special block for d2:weeksBetween(*,*) - add such a block for all other dhis functions.
            if (brokenExecution) {
              //Function call is not possible to evaluate, remove the call:
              evalExpression = evalExpression.replace(fnRegexCall, "false");
              expressionUpdated = true;
            }
            final results = d2FunctionsEval[d2FnVar.name](
                evalExpression, parameters, variableHash, fnRegexCall);
            evalExpression = results.expression;
            expressionUpdated = results.expressionUpdated;
          });
        }
      });
      //We only want to continue looping until we made a successful replacement,

      //and there is still occurrences of "d2:" in the code. In cases where d2: occur outside

      //the expected d2: function calls, one unneccesary iteration will be done and the

      //successfulExecution will be false coming back here, ending the loop. The last iteration

      //should be zero to marginal performancewise.
      if (expressionUpdated && evalExpression.includes("d2:")) {
        continueLooping = true;
      } else {
        continueLooping = false;
      }
    }
  }
  return evalExpression;
};
final runRuleExpression = (String expression, String beforereplacement,
    String identifier, dynamic variablesHash) {
  final String dhisfunctionsevaluated =
      dhisD2Functions(expression, variablesHash);
  try {
    final canEvalRule = eval(dhisfunctionsevaluated);
    return canEvalRule;
  } catch (e, e_stack) {
    return false;
  }
};

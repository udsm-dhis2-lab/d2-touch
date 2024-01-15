import 'package:d2_touch/modules/engine/program_rule/d2-functions.util.dart';

String dhisD2Functions(String expression, Map<String, dynamic> variableHash) {

  // 1. Remove whitespace
  String evalExpression = expression.replaceAll(RegExp(r'\s+'), '');

  if (evalExpression.contains('d2:')) {
    bool continueLooping = true;

    for (int i = 0; i < 10 && continueLooping; i++) {
      bool expressionUpdated = false;
      bool brokenExecution = false;

      d2FunctionsVariables.forEach((d2FnVar) {
        String name = d2FnVar.name;

        Iterable<Match> fnRegexCallArr = getMatches(evalExpression, name).toList();
      
        if (fnRegexCallArr is List<Match> && fnRegexCallArr.isNotEmpty) {
          fnRegexCallArr.forEach((fnRegexCall) {
            String fnParameters = fnRegexCall
                .group(0)!
                .replaceAll(RegExp('(^[^\\(]+\\()|\\)\$'), '')
                .trim();


            List<String?>? parameters = fnParameters.split(',');
             

            if (d2FnVar.parameters != null) {
              int numOfParameters = parameters.length;
              if (numOfParameters != d2FnVar.parameters) {
                brokenExecution = true;
              }
            }

            // if (!brokenExecution ) { 
            //   for (int i = 0; i < parameters.length; i++) {
            //     parameters[i] = runRuleExpression(
            //       parameters[i] ?? '',
            //       d2FnVar.name,
            //       'parameter:$i',
            //       variableHash,
            //     ) as String?;
            //   }
            // }

            if (brokenExecution) {
              evalExpression =
                  evalExpression.replaceFirst(fnRegexCall.group(0)!, 'false');
              expressionUpdated = true;
            }

            Map<String, dynamic> results = d2FunctionsEval[d2FnVar.name]!(
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

// d2:daysBetween(2020-01-01, 2020-01-10)
Iterable<Match> getMatches(String inputString, String name) {
  RegExp regex = RegExp(
     name + r"\(((\d[\d/*+%-.\s]*)|(\'[^\']*\')) *, *((\d[\d/*+%-.\s]*)|(\'[^\']*\'))\)");
  return regex.allMatches(inputString);
}


bool runRuleExpression(String expression, String beforeReplacement,
    String identifier, Map<String, dynamic> variablesHash) {
  try {
    dynamic canEvalRule = dhisD2Functions(expression, variablesHash);
    return canEvalRule;
  } catch (e) {
    return false;
  }
}




import 'package:intl/intl.dart';



class D2Function {
  final String name;
  final int? parameters;

  D2Function(this.name, {this.parameters});
}

final List<D2Function> d2FunctionsVariables = [
  D2Function('d2:daysBetween', parameters: 2),
];

final Map<String, Function> d2FunctionsEval = {
  'd2:daysBetween': (
    String expression,
    List<String> parameters,
    Map<String, dynamic> variableHash,
    String regexFunct,
  ) {
    final date1 = removeQuotes(parameters[0]);
    final date2 = removeQuotes(parameters[1]);
    final daysBetween = DateUtils.daysBetween(date1, date2);
    final newExpression = expression.replaceFirst(regexFunct, '$daysBetween');
    return {'expression': newExpression, 'expressionUpdated': true};
  },
};

String dhisD2Functions(String expression, Map<String, dynamic> variableHash) {
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

bool runRuleExpression(String expression, String beforeReplacement,
    String identifier, Map<String, dynamic> variablesHash) {
  try {
    dynamic canEvalRule = dhisD2Functions(expression, variablesHash);

    return canEvalRule;
  } catch (e) {
    return false;
  }
}


class DateUtils {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  static String getToday() {
    final todayMoment = DateTime.now();
    return _dateFormat.format(todayMoment);
  }

  static int daysBetween(String firstRulesDate, String secondRulesDate) {
    final firstDate = _parseDate(firstRulesDate);
    final secondDate = _parseDate(secondRulesDate);
    return secondDate.difference(firstDate).inDays;
  }

  static int weeksBetween(String firstRulesDate, String secondRulesDate) {
    final firstDate = _parseDate(firstRulesDate);
    final secondDate = _parseDate(secondRulesDate);
    return secondDate.difference(firstDate).inDays ~/ 7;
  }

  static int monthsBetween(String firstRulesDate, String secondRulesDate) {
    final firstDate = _parseDate(firstRulesDate);
    final secondDate = _parseDate(secondRulesDate);
    return _differenceInMonths(secondDate, firstDate);
  }

  static int yearsBetween(String firstRulesDate, String secondRulesDate) {
    final firstDate = _parseDate(firstRulesDate);
    final secondDate = _parseDate(secondRulesDate);
    return secondDate.year - firstDate.year;
  }

  static String addDays(String rulesDate, String daysToAdd) {
    final dateMoment = _parseDate(rulesDate);
    final newDateMoment = dateMoment.add(Duration(days: int.parse(daysToAdd)));
    final newRulesDate = _dateFormat.format(newDateMoment);
    return "'$newRulesDate'";
  }

  static DateTime _parseDate(String date) {
    return _dateFormat.parse(date);
  }

  static int _differenceInMonths(DateTime later, DateTime earlier) {
    return (later.year - earlier.year) * 12 + later.month - earlier.month;
  }
}


Iterable<Match> getMatches(String inputString, String name) {

  RegExp regex = RegExp(
     name + r"\(((\d[\d/*+%-.\s]*)|(\'[^\']*\')) *, *((\d[\d/*+%-.\s]*)|(\'[^\']*\'))\)");

  return regex.allMatches(inputString);
}

int calculateDaysDiff(Match match) {
  String date1String = match.group(1) ?? '';
  String date2String = match.group(3) ?? '';

  DateTime date1 = DateTime.tryParse(removeQuotes(date1String)) ?? DateTime(1970);
  DateTime date2 = DateTime.tryParse(removeQuotes(date2String)) ?? DateTime(1970);

  if (date1 != DateTime(1970) && date2 != DateTime(1970)) {
    Duration difference = date2.difference(date1);
    int daysDiff = difference.inDays;

    return daysDiff;
  } else {
    return -1; // Invalid date format
  }
}


String removeQuotes(String input) {
  return input.replaceAll(RegExp(r"[']"), "").replaceAll(RegExp(r'["]'), "");
}
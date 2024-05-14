import 'package:math_expressions/math_expressions.dart';

class MathExpressions {
  static evaluate(String expression, Map<String, dynamic> data) {
    try {
      RegExp regExp = RegExp(r"#\{(.*?)\}");

      String evaluatedExpression = expression.replaceAllMapped(regExp, (match) {
        String key = match.group(1) ?? '';
        if (data.containsKey(key)) {
          return data[key].toString();
        } else {
          return match.group(0) ?? '';
        }
      });

      Parser parser = Parser();
      Expression parsedExpression = parser.parse(evaluatedExpression);
      ContextModel context = ContextModel();
      return parsedExpression
          .evaluate(EvaluationType.REAL, context)
          .toStringAsFixed(2);
    } catch (e) {
      return expression;
    }
  }
}

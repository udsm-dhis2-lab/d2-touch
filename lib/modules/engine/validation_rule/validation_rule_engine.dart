import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/queries/data_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/engine/shared/utilities/data_value_entities.util.dart';
import 'package:dhis2_flutter_sdk/modules/engine/validation_rule/models/validation_rule_action.model.dart';
import 'package:dhis2_flutter_sdk/modules/engine/validation_rule/models/validation_rule_result.model.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/entities/validation_rule.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/validation_rule.query.dart';
import 'package:expressions/expressions.dart';

class ValidationRuleEngine {
  static Future<ValidationRuleResult> execute(
      {required DataValueSet dataValueSet,
      required String dataSet,
      DataValue? changedDataValue}) async {
    List<ValidationRuleAction> validationRuleActions = [];
    List<ValidationRule> validationRules = await ValidationRuleQuery()
        .where(attribute: 'dataSet', value: dataSet)
        .get();

    List<DataValue> dataValues = await DataValueQuery()
        .where(attribute: 'dataValueSet', value: dataValueSet.id)
        .get();

    final dataValueEntities =
        DataValueEntities.fromAggregateDataValues(dataValues);

    final evaluationContext =
        ValidationRuleEngine._getEvaluationContext(dataValueEntities);

    validationRules.forEach((validationRule) {
      final leftSide = jsonDecode(json.decode(validationRule.leftSide));

      String leftSideConditionForEvaluation = leftSide['expression']
          .replaceAll("#{", "")
          .replaceAll("}", "")
          .replaceAll(".", "");

      final rightSide = jsonDecode(json.decode(validationRule.rightSide));
      String rightSideConditionForEvaluation = rightSide['expression']
          .replaceAll("#{", "")
          .replaceAll("}", "")
          .replaceAll(".", "");

      evaluationContext.keys.forEach((key) {
        final value = evaluationContext[key];

        leftSideConditionForEvaluation =
            leftSideConditionForEvaluation.replaceAll(key, value);
        rightSideConditionForEvaluation =
            rightSideConditionForEvaluation.replaceAll(key, value);
      });

      bool skipLeftSideExpression = false;
      try {
        Expression leftSideExpression =
            Expression.parse(leftSideConditionForEvaluation);
        final leftSideEvaluator = const ExpressionEvaluator();
        var leftSideEvaluationResult =
            leftSideEvaluator.eval(leftSideExpression, evaluationContext);
      } catch (e) {
        skipLeftSideExpression =
            leftSide['missingValueStrategy'] == 'SKIP_IF_ANY_VALUE_MISSING';
      }

      bool skipRightSideExpression = false;
      try {
        Expression rightSideExpression =
            Expression.parse(rightSideConditionForEvaluation);
        final rightSideEvaluator = const ExpressionEvaluator();
        var rightSideEvaluationResult =
            rightSideEvaluator.eval(rightSideExpression, evaluationContext);
      } catch (e) {
        skipRightSideExpression =
            rightSide['missingValueStrategy'] == 'SKIP_IF_ANY_VALUE_MISSING';
      }

      if (!(skipLeftSideExpression || skipRightSideExpression)) {
        String ruleExpressionForEvaluation =
            '$leftSideConditionForEvaluation ${ValidationRuleEngine._getRuleMathOperator(validationRule.operator)} $rightSideConditionForEvaluation';

        try {
          Expression expression = Expression.parse(ruleExpressionForEvaluation);

          final evaluator = const ExpressionEvaluator();
          var evaluationResult = evaluator.eval(expression, evaluationContext);

          if (evaluationResult == false) {
            validationRuleActions.add(ValidationRuleAction(
                instruction: validationRule.displayInstruction as String,
                dataElements: [],
                action: 'SHOWWARNING'));
          }
        } catch (e) {}
      }
    });

    return ValidationRuleResult(
        dataValueSet: dataValueSet,
        validationRuleActions: validationRuleActions);
  }

  static _getEvaluationContext(Map<String, DataValueObject> dataValueEntities) {
    Map<String, dynamic> evaluationContext = {};

    dataValueEntities.keys.forEach((key) {
      evaluationContext[key.replaceAll(".", "")] =
          dataValueEntities[key]?.value;
      evaluationContext[key.split('.')[0]] = dataValueEntities[key]?.value;
    });

    return evaluationContext;
  }

  static String _getRuleMathOperator(String operator) {
    switch (operator) {
      case 'less_than_or_equal_to':
        return '<=';
      case 'less_than':
        return '<';
      case 'greater_than_or_equal_to':
        return '>=';
      case 'greater_than':
        return '>';
      case 'equal':
        return '==';
      case 'not_equal':
        return '!=';
      default:
        return operator;
    }
  }
}

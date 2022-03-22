import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value_set.entity.dart';

import 'validation_rule_action.model.dart';

class ValidationRuleResult {
  DataValueSet dataValueSet;
  List<ValidationRuleAction> validationRuleActions;
  ValidationRuleResult(
      {required this.dataValueSet, required this.validationRuleActions});
}

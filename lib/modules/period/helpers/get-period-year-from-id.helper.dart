import 'package:dhis2_flutter_sdk/modules/period/constants/period-types.constant.dart';

String deducePeriodTypeFromId(String periodId, {radix = 10}) {
  String deducedPeriodType;
  if (periodId.contains('YEAR')) {
    if (periodId.contains('FINANCIAL_YEAR'))
      deducedPeriodType = PeriodTypesEnum.RELATIVE_FINANCIAL_YEAR.value;
    else
      deducedPeriodType = PeriodTypesEnum.RELATIVE_YEAR.value;
  }

  PeriodTypesEnum.values.forEach((periodType) {
    RegExp regex = periodType.regex;

    if (periodType.value == 'Monthly') {
      if (periodId.length > 5) {
        if (int.tryParse(periodId.substring(5)) != null) {
          deducedPeriodType = periodType.value;
        }
      }
    }
    if (periodType.value == 'Yearly') {
      if (periodId.length == 4) {
        deducedPeriodType = periodType.value;
      }
    }

    if (regex.hasMatch(periodId)) {
      deducedPeriodType = periodType.value;
    }
  });

  return deducedPeriodType;
}

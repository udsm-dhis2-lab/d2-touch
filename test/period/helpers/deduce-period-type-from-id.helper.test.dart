import 'package:dhis2_flutter_sdk/modules/period/constants/period-types.constant.dart';
import 'package:dhis2_flutter_sdk/modules/period/helpers/get-period-year-from-id.helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testDeducePeriodTypeHelper();
}

void testDeducePeriodTypeHelper() {
  group('Deduce Period Type Helper', () {
    test('Monthly period type', () {
      expect(deducePeriodTypeFromId('201002'), PeriodTypesEnum.MONTHLY.value);
    });
    test('Quarterly period type', () {
      expect(deducePeriodTypeFromId('2010Q2'), PeriodTypesEnum.QUARTERLY.value);
    });
    test('Relative period type', () {
      expect(deducePeriodTypeFromId('LAST_YEAR'),
          PeriodTypesEnum.RELATIVE_YEAR.value);
    });
    test('Year period type', () {
      expect(deducePeriodTypeFromId('2010'), PeriodTypesEnum.YEARLY.value);
    });

    test('Invalid period id', () {
      expect(deducePeriodTypeFromId('20InVALID'), null);
    });
  });
}

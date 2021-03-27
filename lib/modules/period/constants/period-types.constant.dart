import 'package:dhis2_flutter_sdk/modules/period/interfaces/period-types.interface.dart';

enum PeriodTypes {
  MONTHLY,
  BI_MONTHLY,
  QUARTERLY,
  SIX_MONTHLY,
  SIX_MONTHLY_APRIL,
  SIX_MONTHLY_NOVEMBER,
  YEARLY,
  FINANCIAL_APRIL,
  FINANCIAL_JULY,
  FINANCIAL_OCTOBER,
  FINANCIAL_NOVEMBER,
  RELATIVE_WEEK,
  RELATIVE_MONTH,
  RELATIVE_BI_MONTH,
  RELATIVE_SIX_MONTH,
  RELATIVE_QUARTER,
  RELATIVE_YEAR,
  RELATIVE_FINANCIAL_YEAR
}

extension PeriodTypesExtension on PeriodTypes {
  String get value {
    switch (this) {
      case PeriodTypes.MONTHLY:
        return 'Monthly';
      case PeriodTypes.BI_MONTHLY:
        return 'BiMonthly';
      case PeriodTypes.QUARTERLY:
        return 'Quarterly';
      case PeriodTypes.SIX_MONTHLY:
        return 'SixMonthly';
      case PeriodTypes.SIX_MONTHLY_APRIL:
        return 'SixMonthlyApril';
      case PeriodTypes.SIX_MONTHLY_NOVEMBER:
        return 'SixMonthlyNovember';
      case PeriodTypes.YEARLY:
        return 'Yearly';
      case PeriodTypes.FINANCIAL_APRIL:
        return 'FinancialApril';
      case PeriodTypes.FINANCIAL_JULY:
        return 'FinancialJuly';
      case PeriodTypes.FINANCIAL_OCTOBER:
        return 'FinancialOctober';
      case PeriodTypes.FINANCIAL_NOVEMBER:
        return 'FinancialNovember';
      case PeriodTypes.RELATIVE_WEEK:
        return 'RelativeWeek';
      case PeriodTypes.RELATIVE_MONTH:
        return 'RelativeMonth';
      case PeriodTypes.RELATIVE_BI_MONTH:
        return 'RelativeBiMonth';
      case PeriodTypes.RELATIVE_SIX_MONTH:
        return 'RelativeSixMonth';
      case PeriodTypes.RELATIVE_QUARTER:
        return 'RelativeQuarter';
      case PeriodTypes.RELATIVE_YEAR:
        return 'RelativeYear';
      case PeriodTypes.RELATIVE_FINANCIAL_YEAR:
        return 'RelativeFinancialYear';
    }
  }
}

List<PeriodTypesInterface> get periodTypes {
  return [
    PeriodTypesInterface(
        id: PeriodTypes.MONTHLY.value,
        name: PeriodTypes.MONTHLY.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypes.BI_MONTHLY.value,
        name: PeriodTypes.BI_MONTHLY.value,
        rank: 4),
    PeriodTypesInterface(
        id: PeriodTypes.QUARTERLY.value,
        name: PeriodTypes.QUARTERLY.value,
        rank: 5),
    PeriodTypesInterface(
        id: PeriodTypes.SIX_MONTHLY.value,
        name: PeriodTypes.SIX_MONTHLY.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypes.SIX_MONTHLY_APRIL.value,
        name: PeriodTypes.SIX_MONTHLY_APRIL.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypes.SIX_MONTHLY_NOVEMBER.value,
        name: PeriodTypes.SIX_MONTHLY_NOVEMBER.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypes.YEARLY.value, name: PeriodTypes.YEARLY.value, rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.FINANCIAL_APRIL.value,
        name: PeriodTypes.FINANCIAL_APRIL.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.FINANCIAL_JULY.value,
        name: PeriodTypes.FINANCIAL_JULY.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.FINANCIAL_OCTOBER.value,
        name: PeriodTypes.FINANCIAL_OCTOBER.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.FINANCIAL_NOVEMBER.value,
        name: PeriodTypes.FINANCIAL_NOVEMBER.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_WEEK.value,
        name: PeriodTypes.RELATIVE_WEEK.value,
        rank: 2),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_MONTH.value,
        name: PeriodTypes.RELATIVE_MONTH.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_BI_MONTH.value,
        name: PeriodTypes.RELATIVE_BI_MONTH.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_SIX_MONTH.value,
        name: PeriodTypes.RELATIVE_SIX_MONTH.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_QUARTER.value,
        name: PeriodTypes.RELATIVE_QUARTER.value,
        rank: 5),
    PeriodTypesInterface(
        id: PeriodTypes.RELATIVE_YEAR.value,
        name: PeriodTypes.RELATIVE_YEAR.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypes.MONTHLY.value,
        name: PeriodTypes.MONTHLY.value,
        rank: 7),
  ];
}

import 'package:dhis2_flutter_sdk/modules/period/interfaces/period-types.interface.dart';

enum PeriodTypesEnum {
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

extension PeriodTypesExtension on PeriodTypesEnum {
  String get value {
    switch (this) {
      case PeriodTypesEnum.MONTHLY:
        return 'Monthly';
      case PeriodTypesEnum.BI_MONTHLY:
        return 'BiMonthly';
      case PeriodTypesEnum.QUARTERLY:
        return 'Quarterly';
      case PeriodTypesEnum.SIX_MONTHLY:
        return 'SixMonthly';
      case PeriodTypesEnum.SIX_MONTHLY_APRIL:
        return 'SixMonthlyApril';
      case PeriodTypesEnum.SIX_MONTHLY_NOVEMBER:
        return 'SixMonthlyNovember';
      case PeriodTypesEnum.YEARLY:
        return 'Yearly';
      case PeriodTypesEnum.FINANCIAL_APRIL:
        return 'FinancialApril';
      case PeriodTypesEnum.FINANCIAL_JULY:
        return 'FinancialJuly';
      case PeriodTypesEnum.FINANCIAL_OCTOBER:
        return 'FinancialOctober';
      case PeriodTypesEnum.FINANCIAL_NOVEMBER:
        return 'FinancialNovember';
      case PeriodTypesEnum.RELATIVE_WEEK:
        return 'RelativeWeek';
      case PeriodTypesEnum.RELATIVE_MONTH:
        return 'RelativeMonth';
      case PeriodTypesEnum.RELATIVE_BI_MONTH:
        return 'RelativeBiMonth';
      case PeriodTypesEnum.RELATIVE_SIX_MONTH:
        return 'RelativeSixMonth';
      case PeriodTypesEnum.RELATIVE_QUARTER:
        return 'RelativeQuarter';
      case PeriodTypesEnum.RELATIVE_YEAR:
        return 'RelativeYear';
      case PeriodTypesEnum.RELATIVE_FINANCIAL_YEAR:
        return 'RelativeFinancialYear';
    }
  }

  RegExp get regex {
    switch (this) {
      case PeriodTypesEnum.MONTHLY:
        return RegExp('^(\d{2})\$');
      case PeriodTypesEnum.BI_MONTHLY:
        return RegExp('BIMONTH');
      case PeriodTypesEnum.QUARTERLY:
        return RegExp('Q');
      case PeriodTypesEnum.SIX_MONTHLY:
        return RegExp('S');
      case PeriodTypesEnum.SIX_MONTHLY_APRIL:
        return RegExp('AprilS');
      case PeriodTypesEnum.SIX_MONTHLY_NOVEMBER:
        return RegExp('NovS');
      case PeriodTypesEnum.YEARLY:
        return RegExp('^(\d{4})\$');
      case PeriodTypesEnum.FINANCIAL_APRIL:
        return RegExp('April');
      case PeriodTypesEnum.FINANCIAL_JULY:
        return RegExp('July');
      case PeriodTypesEnum.FINANCIAL_OCTOBER:
        return RegExp('Oct');
      case PeriodTypesEnum.FINANCIAL_NOVEMBER:
        return RegExp('Nov');
      case PeriodTypesEnum.RELATIVE_WEEK:
        return RegExp('WEEK');
      case PeriodTypesEnum.RELATIVE_MONTH:
        return RegExp('MONTH');
      case PeriodTypesEnum.RELATIVE_BI_MONTH:
        return RegExp('BIMONTH');
      case PeriodTypesEnum.RELATIVE_SIX_MONTH:
        return RegExp('SIX_MONTH');
      case PeriodTypesEnum.RELATIVE_QUARTER:
        return RegExp('QUARTER');
      case PeriodTypesEnum.RELATIVE_YEAR:
        return RegExp('YEAR');
      case PeriodTypesEnum.RELATIVE_FINANCIAL_YEAR:
        return RegExp('FINANCIAL_YEAR');
    }
  }
}

List<PeriodTypesInterface> get periodTypes {
  return [
    PeriodTypesInterface(
        id: PeriodTypesEnum.MONTHLY.value,
        name: PeriodTypesEnum.MONTHLY.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypesEnum.BI_MONTHLY.value,
        name: PeriodTypesEnum.BI_MONTHLY.value,
        rank: 4),
    PeriodTypesInterface(
        id: PeriodTypesEnum.QUARTERLY.value,
        name: PeriodTypesEnum.QUARTERLY.value,
        rank: 5),
    PeriodTypesInterface(
        id: PeriodTypesEnum.SIX_MONTHLY.value,
        name: PeriodTypesEnum.SIX_MONTHLY.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypesEnum.SIX_MONTHLY_APRIL.value,
        name: PeriodTypesEnum.SIX_MONTHLY_APRIL.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypesEnum.SIX_MONTHLY_NOVEMBER.value,
        name: PeriodTypesEnum.SIX_MONTHLY_NOVEMBER.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypesEnum.YEARLY.value,
        name: PeriodTypesEnum.YEARLY.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.FINANCIAL_APRIL.value,
        name: PeriodTypesEnum.FINANCIAL_APRIL.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.FINANCIAL_JULY.value,
        name: PeriodTypesEnum.FINANCIAL_JULY.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.FINANCIAL_OCTOBER.value,
        name: PeriodTypesEnum.FINANCIAL_OCTOBER.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.FINANCIAL_NOVEMBER.value,
        name: PeriodTypesEnum.FINANCIAL_NOVEMBER.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_WEEK.value,
        name: PeriodTypesEnum.RELATIVE_WEEK.value,
        rank: 2),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_MONTH.value,
        name: PeriodTypesEnum.RELATIVE_MONTH.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_BI_MONTH.value,
        name: PeriodTypesEnum.RELATIVE_BI_MONTH.value,
        rank: 3),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_SIX_MONTH.value,
        name: PeriodTypesEnum.RELATIVE_SIX_MONTH.value,
        rank: 6),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_QUARTER.value,
        name: PeriodTypesEnum.RELATIVE_QUARTER.value,
        rank: 5),
    PeriodTypesInterface(
        id: PeriodTypesEnum.RELATIVE_YEAR.value,
        name: PeriodTypesEnum.RELATIVE_YEAR.value,
        rank: 7),
    PeriodTypesInterface(
        id: PeriodTypesEnum.MONTHLY.value,
        name: PeriodTypesEnum.MONTHLY.value,
        rank: 7),
  ];
}

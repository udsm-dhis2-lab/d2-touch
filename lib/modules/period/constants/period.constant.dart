enum PeriodSortOrderEnum { ASCENDING, DESCENDING }

extension PeriodSortOrderEnumExtension on PeriodSortOrderEnum {
  String get value {
    switch (this) {
      case PeriodSortOrderEnum.ASCENDING:
        return 'ASC';
      case PeriodSortOrderEnum.DESCENDING:
        return 'DESC';
      default:
        return null;
    }
  }
}

enum Calendar { GREGORIAN, ETHIOPIAN }

extension CalendarEpochExtension on Calendar {
  double get epoch {
    switch (this) {
      case Calendar.ETHIOPIAN:
        return 1723856;
      case Calendar.GREGORIAN:
        return 1721425.5;
      default:
        return null;
    }
  }

  String get name {
    switch (this) {
      case Calendar.ETHIOPIAN:
        return 'Ethiopian';
      case Calendar.GREGORIAN:
        return 'Gregorian';
      default:
        return null;
    }
  }
}

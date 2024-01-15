import 'package:intl/intl.dart';

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

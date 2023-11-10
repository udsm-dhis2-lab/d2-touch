import 'package:intl/intl.dart';

class DateUtils {
  static final String _momentFormat = 'yyyy-MM-dd';

  static int _between(String unit, String firstRulesDate, String secondRulesDate) {
    final firstRulesDateTrimmed = _trimQuotes(firstRulesDate);
    final secondRulesDateTrimmed = _trimQuotes(secondRulesDate);
    final firstDate = DateFormat(_momentFormat).parse(firstRulesDateTrimmed);
    final secondDate = DateFormat(_momentFormat).parse(secondRulesDateTrimmed);
    return secondDate.difference(firstDate).inDays;
  }

  static String _trimQuotes(String input) {
    return input.replaceAll(RegExp(r"'"), '');
  }

  static String getToday() {
    final todayMoment = DateTime.now();
    final formattedToday = DateFormat(_momentFormat).format(todayMoment);
    return formattedToday;
  }

  static int daysBetween(String firstRulesDate, String secondRulesDate) {
    return _between('days', firstRulesDate, secondRulesDate);
  }

  static int weeksBetween(String firstRulesDate, String secondRulesDate) {
    return _between('weeks', firstRulesDate, secondRulesDate);
  }

  static int monthsBetween(String firstRulesDate, String secondRulesDate) {
    return _between('months', firstRulesDate, secondRulesDate);
  }

  static int yearsBetween(String firstRulesDate, String secondRulesDate) {
    return _between('years', firstRulesDate, secondRulesDate);
  }

  static String addDays(String rulesDate, String daysToAdd) {
    final rulesDateTrimmed = _trimQuotes(rulesDate);
    final daysToAddTrimmed = _trimQuotes(daysToAdd);
    final dateMoment = DateFormat(_momentFormat).parse(rulesDateTrimmed);
    final newDateMoment = dateMoment.add(Duration(days: int.parse(daysToAddTrimmed)));
    final newRulesDate = DateFormat(_momentFormat).format(newDateMoment);
    return "'$newRulesDate'";
  }
}
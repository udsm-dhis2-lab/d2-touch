// @flow
import "package:moment.dart" as moment;

const momentFormat = "YYYY-MM-DD";
final between = (dynamic unit, String firstRulesDate, String secondRulesDate) {
  final firsRulesDateTrimmed = trimQuotes(firstRulesDate);
  final secondRulesDateTrimmed = trimQuotes(secondRulesDate);
  final firstDate = moment(firsRulesDateTrimmed, momentFormat);
  final secondDate = moment(secondRulesDateTrimmed, momentFormat);
  return secondDate.diff(firstDate, unit);
};
final dateUtils = {
  "getToday": () {
    final todayMoment = moment();
    return todayMoment.format(momentFormat);
  },
  "daysBetween": (String firstRulesDate, String secondRulesDate) =>
      between("days", firstRulesDate, secondRulesDate),
  "weeksBetween": (String firstRulesDate, String secondRulesDate) =>
      between("weeks", firstRulesDate, secondRulesDate),
  "monthsBetween": (String firstRulesDate, String secondRulesDate) =>
      between("months", firstRulesDate, secondRulesDate),
  "yearsBetween": (String firstRulesDate, String secondRulesDate) =>
      between("years", firstRulesDate, secondRulesDate),
  "addDays": (String rulesDate, String daysToAdd) {
    final rulesDateTrimmed = trimQuotes(rulesDate);
    final daysToAddTrimmed = trimQuotes(daysToAdd);
    final dateMoment = moment(rulesDateTrimmed, momentFormat);
    final newDateMoment = dateMoment.add(daysToAddTrimmed, "days");
    final newRulesDate = newDateMoment.format(momentFormat);
    return newRulesDate;
  }
};

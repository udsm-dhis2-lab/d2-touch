import 'package:meta/meta.dart';

class PeriodInterface {
  String id;
  String startDate;
  String endDate;
  dynamic iso;
  String name;
  String type;
  PeriodInterface lastPeriod;
  List daily;
  List weekly;
  List monthly;
  List quarterly;

  PeriodInterface(
      {@required this.id,
      @required this.name,
      this.daily,
      this.endDate,
      this.iso,
      this.lastPeriod,
      this.monthly,
      this.quarterly,
      this.startDate,
      this.type,
      this.weekly});
}

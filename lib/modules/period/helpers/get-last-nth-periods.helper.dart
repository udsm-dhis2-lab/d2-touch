import 'package:dhis2_flutter_sdk/modules/period/interfaces/period.interface.dart';
import 'package:meta/meta.dart';

int compare(PeriodInterface period1, PeriodInterface period2) {
  return period1.id.compareTo(period2.id);
}

List<PeriodInterface> getLastNthPeriods({
  @required List<PeriodInterface> periods,
  @required PeriodInterface currentPeriod,
  @required int periodCount,
}) {
  if (currentPeriod == null) {
    return <PeriodInterface>[];
  }
  periods.sort(compare);
  periods.removeWhere((period) => currentPeriod.id.compareTo(period.id) < 1);
  periods = periods.sublist(periods.length - periodCount);

  return periods;
}

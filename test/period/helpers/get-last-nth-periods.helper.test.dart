import 'package:dhis2_flutter_sdk/modules/period/helpers/get-last-nth-periods.helper.dart';
import 'package:dhis2_flutter_sdk/modules/period/interfaces/period.interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testGetLastNthPeriodHelper();
}

void testGetLastNthPeriodHelper() {
  List<Map> quarterPeriodsMaps = [
    {
      "id": '2019Q1',
      "type": 'Quarterly',
      "name": 'January 2019 - March 2019',
      "lastPeriod": {"id": '2018Q4', "name": 'October 2018 - December 2018'},
    },
    {
      "id": '2019Q2',
      "type": 'Quarterly',
      "name": 'April 2019 - June 2019',
      "lastPeriod": {"id": '2019Q1', "name": 'January 2019 - March 2019'},
    },
    {
      "id": '2019Q3',
      "type": 'Quarterly',
      "name": 'July 2019 - September 2019',
      "lastPeriod": {"id": '2019Q2', "name": 'April 2019 - June 2019'},
    },
    {
      "id": '2019Q4',
      "type": 'Quarterly',
      "name": 'October 2019 - December 2019',
      "lastPeriod": {"id": '2019Q3', "name": 'July 2019 - September 2019'},
    },
    {
      "id": '2020Q1',
      "type": 'Quarterly',
      "name": 'January 2020 - March 2020',
      "lastPeriod": {"id": '2019Q4', "name": 'October 2019 - December 2019'},
    },
    {
      "id": '2020Q2',
      "type": 'Quarterly',
      "name": 'April 2020 - June 2020',
      "lastPeriod": {"id": '2020Q1', "name": 'January 2020 - March 2020'},
    },
    {
      "id": '2020Q3',
      "type": 'Quarterly',
      "name": 'July 2020 - September 2020',
      "lastPeriod": {"id": '2020Q2', "name": 'April 2020 - June 2020'},
    },
    {
      "id": '2020Q4',
      "type": 'Quarterly',
      "name": 'October 2020 - December 2020',
      "lastPeriod": {"id": '2020Q3', "name": 'July 2020 - September 2020'},
    },
  ];

  PeriodInterface currentQuarter = new PeriodInterface(
      id: '2020Q3',
      name: 'July 2020 - September 2020',
      lastPeriod:
          new PeriodInterface(id: '2020Q2', name: 'April 2020 - June 2020'));

  List<PeriodInterface> quarterPeriods = quarterPeriodsMaps
      .map((period) => new PeriodInterface(
          id: period['id'],
          name: period['name'],
          type: period['type'],
          lastPeriod: new PeriodInterface(
              id: period['lastPeriod']['id'],
              name: period['lastPeriod']['name'])))
      .toList();

  List<PeriodInterface> lastFourQuarters = getLastNthPeriods(
      currentPeriod: currentQuarter, periodCount: 4, periods: quarterPeriods);

  group('get Nth periods', () {
    test('Should return 4 periods', () {
      expect(lastFourQuarters.length, 4);
    });
    test('Should not return current period', () {
      expect(
          lastFourQuarters
              .indexWhere((period) => period.id == currentQuarter.id),
          -1);
    });
    test("Last period should be equal to current period's last period", () {
      expect(lastFourQuarters.last.id == currentQuarter.lastPeriod.id, true);
    });
  });
}

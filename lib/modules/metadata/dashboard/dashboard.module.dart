import 'package:dhis2_flutter_sdk/modules/metadata/dashboard/queries/dashboard.query.dart';

class DashboardModule {
  static createTables() async {
    return await DashboardQuery().createTable();
  }

  DashboardQuery dashboardQuery = DashboardQuery();
}

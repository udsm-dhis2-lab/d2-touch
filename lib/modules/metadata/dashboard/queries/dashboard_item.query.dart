import 'package:dhis2_flutter_sdk/modules/metadata/dashboard/entities/dashboard_item.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DashboardItemQuery extends BaseQuery<DashboardItem> {
  DashboardItemQuery({Database? database}) : super(database: database);
}

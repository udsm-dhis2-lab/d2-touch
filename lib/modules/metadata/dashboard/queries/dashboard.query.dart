import 'package:dhis2_flutter_sdk/modules/metadata/dashboard/entities/dashboard.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DashboardQuery extends BaseQuery<Dashboard> {
  DashboardQuery({Database database}) : super(database: database);
}

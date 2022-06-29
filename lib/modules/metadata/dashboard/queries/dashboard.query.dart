import 'package:d2_touch/modules/metadata/dashboard/entities/dashboard.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DashboardQuery extends BaseQuery<Dashboard> {
  DashboardQuery({Database? database}) : super(database: database);
}

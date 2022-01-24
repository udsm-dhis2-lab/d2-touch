import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class EnrollmentQuery extends BaseQuery<Enrollment> {
  EnrollmentQuery({Database? database}) : super(database: database);
}

import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_file_resource.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class TrackedEntityFileResourceQuery
    extends BaseQuery<TrackedEntityInstanceFileResource> {
  TrackedEntityFileResourceQuery({Database? database})
      : super(database: database);
}

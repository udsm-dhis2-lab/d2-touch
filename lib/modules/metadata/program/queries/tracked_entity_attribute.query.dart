import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/tracked_entity_attribute.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqlite_api.dart';

class TrackedEntityAttributeQuery extends BaseQuery<TrackedEntityAttribute> {
  TrackedEntityAttributeQuery({Database? database}) : super(database: database);
}

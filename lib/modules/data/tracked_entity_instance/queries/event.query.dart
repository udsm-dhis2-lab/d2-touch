import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/entities/event.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class EventQuery extends BaseQuery<Event> {
  EventQuery({Database? database}) : super(database: database);
}

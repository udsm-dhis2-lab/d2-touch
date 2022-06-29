import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class EventDataValueQuery extends BaseQuery<EventDataValue> {
  EventDataValueQuery({Database? database}) : super(database: database);
}

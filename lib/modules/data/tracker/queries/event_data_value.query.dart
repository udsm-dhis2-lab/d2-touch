import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class EventDataValueQuery extends BaseQuery<EventDataValue> {
  EventDataValueQuery({Database? database}) : super(database: database);
}

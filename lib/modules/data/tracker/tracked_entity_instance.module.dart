import 'package:sqflite/sqflite.dart';

import 'queries/attribute_reserved_value.query.dart';
import 'queries/enrollment.query.dart';
import 'queries/event.query.dart';
import 'queries/event_data_value.query.dart';
import 'queries/tracked_entity_attribute_value.query.dart';
import 'queries/tracked_entity_instance.query.dart';

class TrackedEntityInstanceModule {
  static createTables({required Database database}) async {
    await TrackedEntityInstanceQuery(database: database).createTable();
    await TrackedEntityAttributeValueQuery(database: database).createTable();
    await EventQuery(database: database).createTable();
    await EnrollmentQuery(database: database).createTable();
    await AttributeReservedValueQuery(database: database).createTable();
    await EventDataValueQuery(database: database).createTable();
  }

  TrackedEntityInstanceQuery get trackedEntityInstance =>
      TrackedEntityInstanceQuery();

  TrackedEntityAttributeValueQuery get trackedEntityAttributeValue =>
      TrackedEntityAttributeValueQuery();

  EventQuery get event => EventQuery();

  EnrollmentQuery get enrollment => EnrollmentQuery();

  AttributeReservedValueQuery get attributeReservedValue =>
      AttributeReservedValueQuery();

  EventDataValueQuery get eventDataValue => EventDataValueQuery();
}

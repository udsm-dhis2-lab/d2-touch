import 'queries/attribute_reserved_value.query.dart';
import 'queries/enrollment.query.dart';
import 'queries/event.query.dart';
import 'queries/event_data_value.query.dart';
import 'queries/tracked_entity_attribute_value.query.dart';
import 'queries/tracked_entity_instance.query.dart';

class TrackedEntityInstanceModule {
  static createTables() async {
    await TrackedEntityInstanceQuery().createTable();
    await TrackedEntityAttributeValueQuery().createTable();
    await EventQuery().createTable();
    await EnrollmentQuery().createTable();
    await AttributeReservedValueQuery().createTable();
    await EventDataValueQuery().createTable();
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

import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/attribute_reserved_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/enrollment.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/event.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/tracked_entity_attribute_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/queries/tracked_entity_instance.query.dart';

class TrackedEntityInstanceModule {
  static createTables() async {
    await TrackedEntityInstanceQuery().createTable();
    await TrackedEntityAttributeValueQuery().createTable();
    await EventQuery().createTable();
    await EnrollmentQuery().createTable();
    await AttributeReservedValueQuery().createTable();
  }

  TrackedEntityInstanceQuery trackedEntityInstance =
      TrackedEntityInstanceQuery();

  TrackedEntityAttributeValueQuery trackedEntityAttributeValue =
      TrackedEntityAttributeValueQuery();

  EventQuery event = EventQuery();

  EnrollmentQuery enrollment = EnrollmentQuery();

  AttributeReservedValueQuery attributeReservedValue =
      AttributeReservedValueQuery();
}

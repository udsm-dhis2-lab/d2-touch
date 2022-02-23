import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';

class DataValueObject {
  String id;
  String value;
  DataValueObject({required this.id, required this.value});
}

class DataValueEntities {
  static fromAttributeValues(
      List<TrackedEntityAttributeValue> attributeValues) {
    Map<String, DataValueObject> entities = {};

    attributeValues.forEach((attributeValue) {
      entities[attributeValue.attribute] = DataValueObject(
          id: attributeValue.attribute, value: attributeValue.value);
    });

    return entities;
  }

  static fromEventDataValues(List<EventDataValue> eventDataValues) {
    Map<String, DataValueObject> entities = {};

    eventDataValues.forEach((eventDataValue) {
      entities[eventDataValue.dataElement] = DataValueObject(
          id: eventDataValue.dataElement, value: eventDataValue.value);
    });
    return entities;
  }
}

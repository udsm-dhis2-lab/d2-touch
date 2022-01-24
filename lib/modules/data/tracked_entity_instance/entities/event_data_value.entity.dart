import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'event.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'eventDataValue', apiResourceName: 'dataValues')
class EventDataValue extends BaseEntity {
  @Column()
  String dataElement;
  @Column()
  String value;
  @Column()
  String? storedBy;
  @Column()
  String created;
  @Column()
  String lastUpdated;
  @Column()
  bool? synced;
  @Column()
  bool? providedElsewhere;

  @ManyToOne(joinColumnName: 'event', table: Event)
  dynamic event;

  EventDataValue(
      {required String id,
      required this.dataElement,
      required this.value,
      required bool dirty,
      this.storedBy,
      required this.created,
      required this.lastUpdated,
      this.synced,
      this.providedElsewhere})
      : super(id: id, dirty: dirty);

  factory EventDataValue.fromJson(Map<String, dynamic> json) {
    return EventDataValue(
        id: json['id'],
        dataElement: json['dataElement'],
        value: json['value'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataElement'] = this.dataElement;
    data['value'] = this.value;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dirty'] = this.dirty;
    return data;
  }
}

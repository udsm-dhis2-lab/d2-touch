import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'tracked-entity.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'trackedEntityAttributeValue', apiResourceName: 'attributes')
class TrackedEntityAttributeValue extends BaseEntity {
  @Column()
  String attribute;
  @Column()
  String value;
  @Column()
  bool? synced;

  @ManyToOne(
      joinColumnName: 'trackedEntityInstance', table: TrackedEntityInstance)
  dynamic trackedEntityInstance;
  TrackedEntityAttributeValue(
      {required String id,
      required bool dirty,
      required this.attribute,
      required this.value,
      this.synced})
      : super(id: id, dirty: dirty);

  factory TrackedEntityAttributeValue.fromJson(Map<String, dynamic> json) {
    return TrackedEntityAttributeValue(
        id: json['id'],
        attribute: json['attribute'],
        value: json['value'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'attributeReserveValue',
    apiResourceName: 'attributeReserveValues')
class AttributeReservedValue extends BaseEntity {
  @Column()
  String attribute;
  @Column()
  String value;
  @Column()
  String expiryDate;

  AttributeReservedValue(
      {required String id,
      required this.attribute,
      required this.value,
      required this.expiryDate,
      required bool dirty})
      : super(id: id, dirty: dirty);

  factory AttributeReservedValue.fromJson(Map<String, dynamic> json) {
    return AttributeReservedValue(
        id: json['id'],
        attribute: json['attribute'],
        value: json['value'],
        expiryDate: json['expiryDate'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['expiryDate'] = this.expiryDate;
    data['dirty'] = this.dirty;
    return data;
  }
}

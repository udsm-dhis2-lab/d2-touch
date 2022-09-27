import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'attributeReserveValue',
    apiResourceName: 'attributeReserveValues')
class AttributeReservedValue extends IdentifiableEntity {
  @Column()
  String attribute;
  @Column()
  String value;
  @Column()
  String expiryDate;

  AttributeReservedValue(
      {required String id,
      required String name,
      required this.attribute,
      required this.value,
      required this.expiryDate,
      String? created,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty, created: created);

  factory AttributeReservedValue.fromJson(Map<String, dynamic> json) {
    final attribute = json['attribute'] ?? json['ownerUid'];
    final value = json['value'];
    final id = json['id'] ?? '${attribute}_$value';
    return AttributeReservedValue(
        id: id,
        name: id,
        attribute: attribute,
        value: value,
        expiryDate: json['expiryDate'],
        created: json['created'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['expiryDate'] = this.expiryDate;
    data['created'] = this.created;
    data['dirty'] = this.dirty;
    return data;
  }
}

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'attributeoption', apiResourceName: 'attributeOptions')
class AttributeOption extends BaseEntity {
  @Column()
  String attribute;
  @ManyToOne(
      table: ProgramTrackedEntityAttribute,
      joinColumnName: 'programTrackedEntityAttribute')
  dynamic programTrackedEntityAttribute;

  AttributeOption(
      {required String id,
      required String name,
      required String code,
      required this.programTrackedEntityAttribute,
      required this.attribute,
      required bool dirty})
      : super(id: id, name: name, code: code, dirty: dirty);

  factory AttributeOption.fromJson(Map<String, dynamic> jsonData) {
    return AttributeOption(
        id: jsonData['id'],
        name: jsonData['name'],
        code: jsonData['code'],
        programTrackedEntityAttribute:
            jsonData['programTrackedEntityAttribute'],
        attribute: jsonData['attribute'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['programTrackedEntityAttribute'] = this.programTrackedEntityAttribute;
    data['attribute'] = this.attribute;
    data['dirty'] = this.dirty;
    return data;
  }
}

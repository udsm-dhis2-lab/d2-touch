import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'attributeoption', apiResourceName: 'attributeOptions')
class AttributeOption extends BaseEntity {
  @ManyToOne(
      table: ProgramTrackedEntityAttribute,
      joinColumnName: 'programTrackedEntityAttribute')
  dynamic programTrackedEntityAttribute;

  AttributeOption(
      {required String id,
      required String name,
      required String code,
      required this.programTrackedEntityAttribute,
      required bool dirty})
      : super(id: id, name: name, code: code, dirty: dirty);

  factory AttributeOption.fromJson(Map<String, dynamic> jsonData) {
    return AttributeOption(
        id: jsonData['id'],
        name: jsonData['name'],
        code: jsonData['code'],
        programTrackedEntityAttribute:
            jsonData['programTrackedEntityAttribute'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['programTrackedEntityAttribute'] = this.programTrackedEntityAttribute;
    data['dirty'] = this.dirty;
    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/attribute_option.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'optionset', apiResourceName: 'optionSets')
class OptionSet extends BaseEntity {
  @OneToMany(table: AttributeOption)
  List<AttributeOption>? options;

  OptionSet({required String id, required String name, required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory OptionSet.fromJson(Map<String, dynamic> jsonData) {
    return OptionSet(
        id: jsonData['id'], name: jsonData['name'], dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'dataelementoption', apiResourceName: 'dataElementOptions')
class DataElementOption extends BaseEntity {
  @ManyToOne(table: DataElement, joinColumnName: 'dataElement')
  dynamic dataElement;

  DataElementOption(
      {required String id,
      required String name,
      required String code,
      required this.dataElement,
      required bool dirty})
      : super(id: id, name: name, code: code, dirty: dirty);

  factory DataElementOption.fromJson(Map<String, dynamic> jsonData) {
    return DataElementOption(
        id: jsonData['id'],
        name: jsonData['name'],
        code: jsonData['code'],
        dataElement: jsonData['dataElement'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['dataElement'] = this.dataElement;
    data['dirty'] = this.dirty;
    return data;
  }
}

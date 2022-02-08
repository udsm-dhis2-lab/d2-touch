import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/entities/data_set_element.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'datasetelementoption', apiResourceName: 'dataSetElementOptions')
class DataSetElementOption extends BaseEntity {
  @ManyToOne(table: DataSetElement, joinColumnName: 'dataSetElement')
  dynamic dataSetElement;

  DataSetElementOption(
      {required String id,
      required String name,
      required String code,
      required this.dataSetElement,
      required bool dirty})
      : super(id: id, name: name, code: code, dirty: dirty);

  factory DataSetElementOption.fromJson(Map<String, dynamic> jsonData) {
    return DataSetElementOption(
        id: jsonData['id'],
        name: jsonData['name'],
        code: jsonData['code'],
        dataSetElement: jsonData['dataSetElement'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['dataSetElement'] = this.dataSetElement;
    data['dirty'] = this.dirty;
    return data;
  }
}

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programstagedataelementoption',
    apiResourceName: 'programStageDataElementOptions')
class ProgramStageDataElementOption extends BaseEntity {
  @ManyToOne(
      table: ProgramStageDataElement, joinColumnName: 'programStageDataElement')
  dynamic programStageDataElement;

  ProgramStageDataElementOption(
      {required String id,
      required String name,
      required String code,
      required this.programStageDataElement,
      required bool dirty})
      : super(id: id, name: name, code: code, dirty: dirty);

  factory ProgramStageDataElementOption.fromJson(
      Map<String, dynamic> jsonData) {
    return ProgramStageDataElementOption(
        id: jsonData['id'],
        name: jsonData['name'],
        code: jsonData['code'],
        programStageDataElement: jsonData['programStageDataElement'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['programStageDataElement'] = this.programStageDataElement;
    data['dirty'] = this.dirty;
    return data;
  }
}

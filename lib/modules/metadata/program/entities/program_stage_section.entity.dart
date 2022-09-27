import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programstagesection', apiResourceName: 'programStageSections')
class ProgramStageSection extends IdentifiableEntity {
  @ManyToOne(table: ProgramStage, joinColumnName: 'programStage')
  dynamic programStage;

  ProgramStageSection(
      {required String id, required bool dirty, this.programStage})
      : super(id: id, dirty: dirty);

  factory ProgramStageSection.fromJson(Map<String, dynamic> jsonData) {
    return ProgramStageSection(
        id: jsonData['id'],
        dirty: jsonData['dirty'],
        programStage: jsonData['programStage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['id'] = this.dirty;
    data['programStage'] = this.programStage;
    return data;
  }
}

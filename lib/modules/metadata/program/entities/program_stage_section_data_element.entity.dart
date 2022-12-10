import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programstagesectiondataelement',
    apiResourceName: 'programStageSectionDataElements')
class ProgramStageSectionDataElement extends BaseEntity {
  @Column()
  String dataElement;

  @ManyToOne(joinColumnName: 'programStageSection', table: ProgramStageSection)
  dynamic programStageSection;

  ProgramStageSectionDataElement(
      {required String id,
      required bool dirty,
      String? created,
      String? lastUpdated,
      required this.dataElement,
      required this.programStageSection})
      : super(id: id, dirty: dirty, created: created, lastUpdated: lastUpdated);

  factory ProgramStageSectionDataElement.fromJson(
      Map<String, dynamic> jsonData) {
    return ProgramStageSectionDataElement(
        id: '${jsonData['programStageSection']}_${jsonData['dataElement']}',
        dirty: jsonData['dirty'],
        dataElement: jsonData['dataElement'],
        programStageSection: jsonData['programStageSection'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dataElement'] = this.dataElement;
    data['programStageSection'] = this.programStageSection;
    data['dirty'] = this.dirty;
    return data;
  }
}

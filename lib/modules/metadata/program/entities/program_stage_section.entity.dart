import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section_data_element.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programstagesection', apiResourceName: 'programStageSections')
class ProgramStageSection extends IdentifiableEntity {
  @Column(nullable: true)
  String? formName;

  @Column(nullable: true)
  String? description;

  @Column()
  int sortOrder;

  @Column(nullable: true)
  String? renderType;

  @OneToMany(table: ProgramStageSectionDataElement)
  List<ProgramStageSectionDataElement>? dataElements;

  @ManyToOne(table: ProgramStage, joinColumnName: 'programStage')
  dynamic programStage;

  ProgramStageSection(
      {required String id,
      required bool dirty,
      required String created,
      required String lastUpdated,
      required String name,
      required String displayName,
      this.description,
      required this.sortOrder,
      this.formName,
      this.renderType,
      this.dataElements,
      this.programStage})
      : super(id: id, dirty: dirty);

  factory ProgramStageSection.fromJson(Map<String, dynamic> jsonData) {
    final renderType = jsonData['renderType'] is String
        ? jsonData['renderType']
        : jsonData['renderType']?['MOBILE']?['type'];
    return ProgramStageSection(
        id: jsonData['id'],
        dirty: jsonData['dirty'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated'],
        name: jsonData['name'],
        formName: jsonData['formName'] ?? jsonData['displayFormName'],
        renderType: renderType,
        description: jsonData['description'],
        displayName: jsonData['displayName'],
        sortOrder: jsonData['sortOrder'],
        programStage: jsonData['programStage'],
        dataElements: List<dynamic>.from(jsonData['dataElements'] ?? [])
            .map((dataElement) => ProgramStageSectionDataElement.fromJson({
                  ...dataElement,
                  'programStageSection': jsonData['id'],
                  'dirty': false
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['id'] = this.dirty;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['formName'] = this.formName;
    data['description'] = this.description;
    data['renderType'] = this.renderType;
    data['programStage'] = this.programStage;
    data['sortOrder'] = this.sortOrder;
    data['dataElements'] = this.dataElements;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }
}

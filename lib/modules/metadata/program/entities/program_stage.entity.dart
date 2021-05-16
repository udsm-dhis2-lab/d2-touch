import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'programstage')
class ProgramStage extends BaseEntity {
  @Column(type: ColumnType.INTEGER, name: 'sortorder')
  int sortOrder;

  @Column(type: ColumnType.TEXT, name: 'executiondatelabel')
  String executionDateLabel;

  @Column(type: ColumnType.TEXT, name: 'description', nullable: true)
  String description;

  @Column(type: ColumnType.TEXT, name: 'formtype')
  String formType;

  @Column(type: ColumnType.BOOLEAN, name: 'blockentryform')
  bool blockEntryForm;

  @Column(type: ColumnType.BOOLEAN, name: 'hideduedate')
  bool hideDueDate;

  @Column(type: ColumnType.BOOLEAN, name: 'repeatable')
  bool repeatable;

  @Column(type: ColumnType.BOOLEAN, name: 'allowgeneratenextvisit')
  bool allowGenerateNextVisit;

  @Column(type: ColumnType.TEXT, name: 'mindaysfromstart')
  int minDaysFromStart;

  @Column(type: ColumnType.BOOLEAN, name: 'generatedbyenrollmentdate')
  bool generatedByEnrollmentDate;

  @Column(type: ColumnType.BOOLEAN, name: 'autogenerateevent')
  bool autoGenerateEvent;

  @Column(type: ColumnType.BOOLEAN, name: 'capturecoordinates')
  bool captureCoordinates;

  @Column(type: ColumnType.TEXT, name: 'featuretype')
  String featureType;

  @Column(type: ColumnType.TEXT, name: 'duedatelabel')
  String dueDateLabel;

  @Column(type: ColumnType.TEXT, name: 'programstagesections')
  List<dynamic> programStageSections;

  @Column(type: ColumnType.TEXT, name: 'programstagedataelements')
  List<dynamic> programStageDataElements;

  @ManyToOne(joinColumnName: 'program')
  Program program;

  // @OneToMany(() => EventEntity, (event) => event.programStage, {
  //   cascade: true,
  // })
  // events: EventEntity[];

  ProgramStage(
      {@required String id,
      String created,
      String lastUpdated,
      @required String name,
      @required String shortName,
      String code,
      String displayName,
      @required this.featureType,
      @required this.captureCoordinates,
      @required this.sortOrder,
      @required this.allowGenerateNextVisit,
      @required this.autoGenerateEvent,
      @required this.blockEntryForm,
      @required this.dueDateLabel,
      @required this.executionDateLabel,
      @required this.formType,
      @required this.generatedByEnrollmentDate,
      @required this.hideDueDate,
      @required this.minDaysFromStart,
      @required this.program,
      @required this.programStageDataElements,
      @required this.programStageSections,
      @required this.repeatable,
      this.description,
      @required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory ProgramStage.fromJson(Map<String, dynamic> json) {
    return ProgramStage(
      id: json['id'],
      name: json['name'],
      created: json['created'],
      shortName: json['shortname'],
      code: json['code'],
      displayName: json['displayname'],
      description: json['description'],
      dirty: json['dirty'],
      captureCoordinates: json['capturecoordinates'],
      featureType: json['featuretype'],
      allowGenerateNextVisit: json['allowgeneratenextvisit'],
      autoGenerateEvent: json['autogenerateevent'],
      blockEntryForm: json['blockentryform'],
      dueDateLabel: json['duedatelabel'],
      executionDateLabel: json['executiondatelabel'],
      formType: json['formtype'],
      generatedByEnrollmentDate: json['generatedbyenrollmentdate'],
      hideDueDate: json['hideduedate'],
      minDaysFromStart: json['mindaysfromstart'],
      program: json['program'],
      programStageDataElements: json['programstagedataelements'],
      programStageSections: json['programstagesections'],
      repeatable: json['repeatable'],
      sortOrder: json['sortorder'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    data['description'] = this.description;
    data['dirty'] = this.dirty;
    data['captureCoordinates'] = this.captureCoordinates;
    data['featureType'] = this.featureType;
    data['allowGenerateNextVisit'] = this.allowGenerateNextVisit;
    data['autoGenerateEvent'] = this.autoGenerateEvent;
    data['blockEntryForm'] = this.blockEntryForm;
    data['captureCoordinates'] = this.captureCoordinates;
    data['dueDateLabel'] = this.dueDateLabel;
    data['executionDateLabel'] = this.executionDateLabel;
    data['featureType'] = this.featureType;
    data['formType'] = this.formType;
    data['generatedByEnrollmentDate'] = this.generatedByEnrollmentDate;
    data['hideDueDate'] = this.hideDueDate;
    data['minDaysFromStart'] = this.minDaysFromStart;
    data['program'] = this.program.toJson();
    data['programStageDataElements'] = this.programStageDataElements;
    data['programStageSections'] = this.programStageSections;
    data['repeatable'] = this.repeatable;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}

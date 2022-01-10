import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'program', apiResourceName: 'programs')
class Program extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String programType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? displayIncidentDate;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? description;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? withoutRegistration;

  @Column(type: ColumnType.BOOLEAN)
  bool ignoreOverdueEvents;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? captureCoordinates;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? featureType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? enrollmentDateLabel;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? onlyEnrollOnce;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? selectIncidentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? selectEnrollmentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? useFirstStageDuringRegistration;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? incidentDateLabel;

  @Column(type: ColumnType.INTEGER, nullable: true)
  int? completeEventsExpiryDays;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? displayFrontPageList;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? trackedEntity;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? trackedEntityType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? organisationUnits;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? programRuleVariables;

  // @OneToMany(() => ProgramStageEntity, (programStage) => programStage.program, {
  //   cascade: true,
  // })
  // programStages: ProgramStageEntity[];

  // @OneToMany(() => ProgramIndicatorEntity, (programIndicator) => programIndicator.program, {
  //   cascade: true,
  // })
  // programIndicators: ProgramIndicatorEntity[];

  // @OneToMany(
  //   () => ProgramTrackedEntityAttributeEntity,
  //   (programTrackedEntityAttribute) => programTrackedEntityAttribute.program,
  //   { cascade: true }
  // )
  // programTrackedEntityAttributes: ProgramTrackedEntityAttributeEntity[];

  // @OneToMany(() => ProgramRuleEntity, (programRule) => programRule.program)
  // programRules: ProgramRuleEntity[];

  @OneToMany()
  List<ProgramStage>? programStages;

  Program(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required String shortName,
      String? code,
      String? displayName,
      required this.programType,
      this.featureType,
      this.captureCoordinates,
      this.completeEventsExpiryDays,
      this.displayFrontPageList,
      this.displayIncidentDate,
      this.enrollmentDateLabel,
      required this.ignoreOverdueEvents,
      this.incidentDateLabel,
      this.onlyEnrollOnce,
      this.organisationUnits,
      this.programRuleVariables,
      this.programStages,
      this.selectEnrollmentDatesInFuture,
      this.description,
      this.selectIncidentDatesInFuture,
      this.trackedEntity,
      this.trackedEntityType,
      this.useFirstStageDuringRegistration,
      this.withoutRegistration,
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

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      created: json['created'],
      shortName: json['shortName'],
      code: json['code'],
      displayName: json['displayName'],
      description: json['description'],
      dirty: json['dirty'],
      captureCoordinates: json['captureCoordinates'],
      completeEventsExpiryDays: json['completeEventsExpiryDays'],
      displayFrontPageList: json['displayFrontPageList'],
      displayIncidentDate: json['displayIncidentDate'],
      enrollmentDateLabel: json['enrollmentDateLabel'],
      featureType: json['featureType'],
      ignoreOverdueEvents: json['ignoreOverdueEvents'],
      incidentDateLabel: json['incidentDateLabel'],
      onlyEnrollOnce: json['onlyEnrollOnce'],
      organisationUnits: json['organisationUnits'],
      programRuleVariables: json['programRuleVariables'],
      programType: json['programType'],
      selectEnrollmentDatesInFuture: json['selectEnrollmentDatesInFuture'],
      selectIncidentDatesInFuture: json['selectIncidentDatesInFuture'],
      trackedEntity: json['trackedEntity'],
      trackedEntityType: json['trackedEntityType'],
      useFirstStageDuringRegistration: json['useFirstStageDuringRegistration'],
      withoutRegistration: json['withoutRegistration'],
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
    data['completeEventsExpiryDays'] = this.completeEventsExpiryDays;
    data['displayFrontPageList'] = this.displayFrontPageList;
    data['displayIncidentDate'] = this.displayIncidentDate;
    data['enrollmentDateLabel'] = this.enrollmentDateLabel;
    data['featureType'] = this.featureType;
    data['ignoreOverdueEvents'] = this.ignoreOverdueEvents;
    data['incidentDateLabel'] = this.incidentDateLabel;
    data['onlyEnrollOnce'] = this.onlyEnrollOnce;
    data['organisationUnits'] = this.organisationUnits;
    data['programRuleVariables'] = this.programRuleVariables;
    data['programType'] = this.programType;
    data['selectEnrollmentDatesInFuture'] = this.selectEnrollmentDatesInFuture;
    data['selectIncidentDatesInFuture'] = this.selectIncidentDatesInFuture;
    data['trackedEntity'] = this.trackedEntity;
    data['trackedEntityType'] = this.trackedEntityType;
    data['useFirstStageDuringRegistration'] =
        this.useFirstStageDuringRegistration;
    data['withoutRegistration'] = this.withoutRegistration;
    return data;
  }
}

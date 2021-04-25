import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'program')
class Program extends BaseEntity {
  @Column(type: ColumnType.TEXT, name: 'programtype')
  String programType;

  @Column(type: ColumnType.TEXT, name: 'displayincidentdate', nullable: true)
  String displayIncidentDate;

  @Column(type: ColumnType.TEXT, name: 'description', nullable: true)
  String description;

  @Column(type: ColumnType.BOOLEAN, name: 'withoutregistration')
  bool withoutRegistration;

  @Column(type: ColumnType.BOOLEAN, name: 'ignoreoverdueevents')
  bool ignoreOverdueEvents;

  @Column(type: ColumnType.BOOLEAN, name: 'capturecoordinates')
  bool captureCoordinates;

  @Column(type: ColumnType.TEXT, name: 'featuretype')
  String featureType;

  @Column(type: ColumnType.TEXT, name: 'enrollmentdatelabel')
  String enrollmentDateLabel;

  @Column(type: ColumnType.BOOLEAN, name: 'onlyenrollonce')
  bool onlyEnrollOnce;

  @Column(type: ColumnType.BOOLEAN, name: 'selectincidentdatesinfuture')
  bool selectIncidentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, name: 'selectenrollmentdatesinfuture')
  bool selectEnrollmentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, name: 'usefirststageduringregistration')
  bool useFirstStageDuringRegistration;

  @Column(type: ColumnType.TEXT, name: 'incidentdatelabel')
  String incidentDateLabel;

  @Column(type: ColumnType.INTEGER, name: 'completeeventsexpirydays')
  int completeEventsExpiryDays;

  @Column(
      type: ColumnType.BOOLEAN, name: 'displayfrontpagelist', nullable: true)
  bool displayFrontPageList;

  @Column(type: ColumnType.TEXT, name: 'trackedentity')
  String trackedEntity;

  @Column(type: ColumnType.TEXT, name: 'trackedentitytype')
  String trackedEntityType;

  @Column(type: ColumnType.TEXT, name: 'organisationunits')
  String organisationUnits;

  @Column(type: ColumnType.TEXT, name: 'programrulevariables')
  String programRuleVariables;

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

  Program(
      {@required String id,
      String created,
      String lastUpdated,
      @required String name,
      @required String shortName,
      String code,
      String displayName,
      @required this.programType,
      @required this.featureType,
      @required this.captureCoordinates,
      @required this.completeEventsExpiryDays,
      this.displayFrontPageList,
      @required this.displayIncidentDate,
      @required this.enrollmentDateLabel,
      @required this.ignoreOverdueEvents,
      @required this.incidentDateLabel,
      @required this.onlyEnrollOnce,
      @required this.organisationUnits,
      @required this.programRuleVariables,
      @required this.selectEnrollmentDatesInFuture,
      this.description,
      @required this.selectIncidentDatesInFuture,
      @required this.trackedEntity,
      @required this.trackedEntityType,
      @required this.useFirstStageDuringRegistration,
      @required this.withoutRegistration,
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
      shortName: json['shortname'],
      code: json['code'],
      displayName: json['displayname'],
      description: json['description'],
      dirty: json['dirty'],
      captureCoordinates: json['capturecoordinates'],
      completeEventsExpiryDays: json['completeeventsexpirydays'],
      displayFrontPageList: json['displayfrontpagelist'],
      displayIncidentDate: json['displayincidentdate'],
      enrollmentDateLabel: json['enrollmentdatelabel'],
      featureType: json['featuretype'],
      ignoreOverdueEvents: json['ignoreoverdueevents'],
      incidentDateLabel: json['incidentdatelabel'],
      onlyEnrollOnce: json['onlyenrollonce'],
      organisationUnits: json['organisationunits'],
      programRuleVariables: json['programrulevariables'],
      programType: json['programtype'],
      selectEnrollmentDatesInFuture: json['selectenrollmentdatesinfuture'],
      selectIncidentDatesInFuture: json['selectincidentdatesinfuture'],
      trackedEntity: json['trackedentity'],
      trackedEntityType: json['trackedentitytype'],
      useFirstStageDuringRegistration: json['usefirststageduringregistration'],
      withoutRegistration: json['withoutregistration'],
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

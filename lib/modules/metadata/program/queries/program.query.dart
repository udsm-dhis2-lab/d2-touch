import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramQuery extends BaseQuery<Program> {
  ProgramQuery({Database? database}) : super(database: database);

  ProgramQuery withProgramStages() {
    final programStage = Repository<ProgramStage>();
    final Column? relationColumn = programStage.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'programStages',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramStage) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStage) as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  ProgramQuery withAttributes() {
    final programAttribute = Repository<ProgramTrackedEntityAttribute>();
    final Column? relationColumn = programAttribute.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'programTrackedEntityAttributes',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramTrackedEntityAttribute)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramTrackedEntityAttribute)
                  as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  @override
  String get dhisUrl {
    final apiFilter =
        QueryFilter.getApiFilters(this.repository.columns, this.filters);
    return 'programs.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariable,programTrackedEntityAttributes[id,name,displayName,attributeValues,mandatory,renderOptionsAsRadio,sortOrder,valueType,trackedEntityAttribute[id,code,name,displayName,shortName,aggregationType,unique,generated,optionSetValue,optionSet[id,name,options[code,name,id]]]],programStages[id,name,created,lastUpdated,formType,generatedByEnrollmentDate,displayFormName,sortOrder,hideDueDate,enableUserAssignment,minDaysFromStart,executionDateLabel,preGenerateUID,displayName,description,displayExecutionDateLabel,openAfterEnrollment,repeatable,featureType,remindCompleted,displayGenerateEventBox,validationStrategy,autoGenerateEvent,blockEntryForm,programStageDataElements[id,created,lastUpdated,displayInReports,skipSynchronization,renderOptionsAsRadio,allowFutureDate,compulsory,allowProvidedElseWhere,sortOrder,dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]]&paging=false';
  }
}

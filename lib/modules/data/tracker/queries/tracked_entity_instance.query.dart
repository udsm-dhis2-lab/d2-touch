import 'dart:convert';

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/enrollment.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/tracked_entity_attribute_value.query.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/mirrors.dart';
import 'package:sqflite/sqflite.dart';

class TrackedEntityInstanceQuery extends BaseQuery<TrackedEntityInstance> {
  String? orgUnit;
  String? program;
  TrackedEntityInstanceQuery({Database? database}) : super(database: database);

  TrackedEntityInstanceQuery withAttributes() {
    final attributeValue = Repository<TrackedEntityAttributeValue>();

    final Column? relationColumn = attributeValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'attributes',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery withEnrollments() {
    final enrollment = Repository<Enrollment>();
    final Column? relationColumn = enrollment.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'enrollments',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this;
  }

  TrackedEntityInstanceQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  String get dhisUrl {
    return 'trackedEntityInstances.json?ou=${this.orgUnit}&program=${this.program}&programStatus=ACTIVE&pageSize=50&order=lastUpdated:desc&fields=*';
  }

  Future<List<TrackedEntityInstance>?> upload(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<TrackedEntityInstance> trackedEntityInstances = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    final List<String> trackedEntityInstanceIds = trackedEntityInstances
        .map((trackedEntityInstance) => trackedEntityInstance.id)
        .toList();

    List<TrackedEntityAttributeValue> attributes =
        await TrackedEntityAttributeValueQuery()
            .whereIn(
                attribute: 'trackedEntityInstance',
                values: trackedEntityInstanceIds,
                merge: false)
            .get();

    List<Enrollment> enrollments = await EnrollmentQuery()
        .whereIn(
            attribute: 'trackedEntityInstance',
            values: trackedEntityInstanceIds,
            merge: false)
        .get();

    final trackedEntityInstanceUploadPayload =
        trackedEntityInstances.map((trackedEntityInstance) {
      trackedEntityInstance.attributes = attributes
          .where((attribute) =>
              attribute.trackedEntityInstance == trackedEntityInstance.id)
          .toList();

      trackedEntityInstance.enrollments = enrollments
          .where((enrollment) =>
              enrollment.trackedEntityInstance == trackedEntityInstance.id)
          .toList();

      return TrackedEntityInstance.toUpload(trackedEntityInstance);
    }).toList();

    final response = await HttpClient.post(this.apiResourceName as String,
        {'trackedEntityInstances': trackedEntityInstanceUploadPayload},
        database: this.database, dioTestClient: dioTestClient);

    final List<dynamic> importSummaries =
        (response.body?['response']?['importSummaries'] ?? []).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    trackedEntityInstances.forEach((trackedEntityInstance) {
      final importSummary = importSummaries.lastWhere(
          (summary) => summary['reference'] == trackedEntityInstance.id);

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        trackedEntityInstance.synced = !syncFailed;
        trackedEntityInstance.dirty = syncFailed;
        trackedEntityInstance.syncFailed = syncFailed;
        trackedEntityInstance.lastSyncDate = DateTime.now().toIso8601String();
        trackedEntityInstance.lastSyncSummary = importSummary.toString();
        queue.add(() =>
            TrackedEntityInstanceQuery().setData(trackedEntityInstance).save());
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return await TrackedEntityInstanceQuery()
        .byIds(trackedEntityInstanceIds)
        .get();

    // TODO 7 Fetch Events and data values
    // TODO 8 Upload events and data values
    // TODO 9 Update sync status for events and data values
  }
}

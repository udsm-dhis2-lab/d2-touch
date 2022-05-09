import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user_organisation_unit.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/attribute_reserved_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/enrollment.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
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
  bool? useUserOrgUnit;
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
    return this.where(attribute: 'orgUnit', value: orgUnit);
  }

  TrackedEntityInstanceQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  TrackedEntityInstanceQuery byUserOrgUnit() {
    this.useUserOrgUnit = true;
    return this;
  }

  @override
  get({Dio? dioTestClient, bool? online}) async {
    if (this.program != null) {
      EnrollmentQuery enrollmentQuery = EnrollmentQuery();

      enrollmentQuery.where(attribute: 'program', value: this.program);

      if (this.orgUnit != null) {
        enrollmentQuery.where(attribute: 'orgUnit', value: this.orgUnit);
      }

      List<Enrollment> enrollments = await enrollmentQuery.get();

      if (enrollments.isEmpty) {
        return [];
      }

      List<String> trackedEntityAttributeIds = [];

      enrollments.forEach((enrollment) {
        String? availableId;

        try {
          availableId = trackedEntityAttributeIds.firstWhere(
            (id) => enrollment.trackedEntityInstance == id,
          );
        } catch (e) {}

        if (availableId == null) {
          trackedEntityAttributeIds.add(enrollment.trackedEntityInstance);
        }
      });

      this.byIds(trackedEntityAttributeIds);

      return this.repository.findAll(
          database: this.database,
          filters: this.filters,
          fields: this.fields as List<String>,
          sortOrder: this.sortOrder,
          relations: this.relations) as Future<List<TrackedEntityInstance>>;
    }

    if (this.id != null) {
      return this.repository.find(
          id: this.id,
          fields: this.fields as List<String>,
          database: this.database,
          relations: this.relations) as Future<List<TrackedEntityInstance>>;
    }

    return this.repository.findAll(
        database: this.database,
        filters: this.filters,
        fields: this.fields as List<String>,
        sortOrder: this.sortOrder,
        relations: this.relations) as Future<List<TrackedEntityInstance>>;
  }

  @override
  Future create() async {
    final Program program = await ProgramQuery()
        .byId(this.program as String)
        .withAttributes()
        .getOne();

    TrackedEntityInstance trackedEntityInstance = TrackedEntityInstance(
      orgUnit: this.orgUnit as String,
      dirty: true,
      trackedEntityType: program.trackedEntityType as String,
    );

    Enrollment enrollment = Enrollment(
        trackedEntityType: program.trackedEntityType as String,
        orgUnit: this.orgUnit as String,
        program: program.id as String,
        trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
        status: 'ACTIVE',
        dirty: true);

    trackedEntityInstance.enrollments = [enrollment];

    final List<ProgramTrackedEntityAttribute> reservedAttributes =
        (program.programTrackedEntityAttributes ?? [])
            .where((attribute) => attribute.generated == true)
            .toList();

    List<TrackedEntityAttributeValue> attributeValues = [];

    await Future.wait(reservedAttributes.map((attribute) async {
      final AttributeReservedValue? attributeReservedValue =
          await AttributeReservedValueQuery()
              .where(attribute: 'attribute', value: attribute.attribute)
              .getOne();

      if (attributeReservedValue != null) {
        final String id =
            '${trackedEntityInstance.trackedEntityInstance}_${attribute.attribute}';
        attributeValues.add(TrackedEntityAttributeValue(
            id: id,
            name: id,
            dirty: true,
            attribute: attribute.attribute,
            trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
            value: attributeReservedValue.value));

        await AttributeReservedValueQuery()
            .byId(attributeReservedValue.id as String)
            .delete();
      }

      return null;
    }));

    trackedEntityInstance.attributes = attributeValues;

    this.data = trackedEntityInstance;

    await this.save();

    return trackedEntityInstance;
  }

  Future<String> dhisUrl() async {
    if (this.useUserOrgUnit == true) {
      final userOrgUnits = await UserOrganisationUnitQuery().get();

      this.orgUnit =
          userOrgUnits.map((userOrgUnit) => userOrgUnit.orgUnit).join(';');
    }

    return Future.value(
        'trackedEntityInstances.json?ou=${this.orgUnit}&program=${this.program}&programStatus=ACTIVE&pageSize=50&order=created:desc&fields=*');
  }

  Future<List<TrackedEntityInstance>?> upload(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<TrackedEntityInstance> trackedEntityInstances = await this
        .withAttributes()
        .withEnrollments()
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    final List<String> trackedEntityInstanceIds = trackedEntityInstances
        .map((trackedEntityInstance) => trackedEntityInstance.id as String)
        .toList();

    final trackedEntityInstanceUploadPayload =
        trackedEntityInstances.map((trackedEntityInstance) {
      return TrackedEntityInstance.toUpload(trackedEntityInstance);
    }).toList();

    final response = await HttpClient.post(this.apiResourceName as String,
        {'trackedEntityInstances': trackedEntityInstanceUploadPayload},
        database: this.database, dioTestClient: dioTestClient);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} is completed.',
            status: '',
            percentage: 75),
        true);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Saving import summaries into the phone database...',
            status: '',
            percentage: 76),
        true);

    final List<dynamic> importSummaries =
        (response.body?['response']?['importSummaries'] ?? []).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    trackedEntityInstances.forEach((trackedEntityInstance) {
      final importSummary = importSummaries.lastWhere(
          (summary) => summary['reference'] == trackedEntityInstance.id,
          orElse: (() => null));

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        trackedEntityInstance.synced = !syncFailed;
        trackedEntityInstance.dirty = true;
        trackedEntityInstance.syncFailed = syncFailed;
        trackedEntityInstance.lastSyncDate =
            DateTime.now().toIso8601String().split('.')[0];
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

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Import summaries saved succussfully',
            status: '',
            percentage: 100),
        true);

    return await TrackedEntityInstanceQuery()
        .byIds(trackedEntityInstanceIds)
        .get();
  }
}

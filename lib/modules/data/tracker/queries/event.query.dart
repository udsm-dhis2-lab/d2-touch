import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/event_data_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class EventQuery extends BaseQuery<Event> {
  String? orgUnit;
  String? program;
  String? programStage;
  EventQuery({Database? database}) : super(database: database);

  EventQuery withAttributes() {
    final eventDataValue = Repository<EventDataValue>();

    final Column? relationColumn = eventDataValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'dataValues',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(EventDataValue) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(EventDataValue) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  EventQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this;
  }

  EventQuery byProgram(String program) {
    this.program = program;

    return this;
  }

  EventQuery byProgramStage(String programStage) {
    this.programStage = programStage;
    return this;
  }

  @override
  String get dhisUrl {
    return 'events.json?fields=event,dueDate,program,programStage,orgUnit,trackedEntityInstance,enrollment,enrollmentStatus,status,attributeCategoryOptions,lastUpdated,created,followup,deleted,attributeOptionCombo,dataValues[dataElement,value,lastUpdated,created,storedBy,providedElseWhere]&orgUnit=${this.orgUnit}&program=${this.program}${this.programStage != null ? '&programStage=${this.programStage}' : ''}&order=eventDate:desc&pageSize=100&page=1';
  }

  @override
  Future create() async {
    final Program program = await ProgramQuery()
        .byId(this.program as String)
        .withAttributes()
        .getOne();

    Event trackedEntityInstance = Event(
        orgUnit: this.orgUnit as String,
        status: 'ACTIVE',
        enrollment: '',
        dirty: true,
        programStage: this.programStage);

    // final List<ProgramTrackedEntityAttribute> reservedAttributes =
    //     (program.programTrackedEntityAttributes ?? [])
    //         .where((attribute) => attribute.generated == true)
    //         .toList();

    // List<TrackedEntityAttributeValue> attributeValues = [];

    // await Future.wait(reservedAttributes.map((attribute) async {
    //   final AttributeReservedValue? attributeReservedValue =
    //       await AttributeReservedValueQuery()
    //           .where(attribute: 'attribute', value: attribute.attribute)
    //           .getOne();

    //   if (attributeReservedValue != null) {
    //     final String id =
    //         '${trackedEntityInstance.trackedEntityInstance}_${attribute.attribute}';
    //     attributeValues.add(TrackedEntityAttributeValue(
    //         id: id,
    //         name: id,
    //         dirty: true,
    //         attribute: attribute.attribute,
    //         trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
    //         value: attributeReservedValue.value));

    //     await AttributeReservedValueQuery()
    //         .byId(attributeReservedValue.id as String)
    //         .delete();
    //   }

    //   return null;
    // }));

    // trackedEntityInstance.attributes = attributeValues;

    this.data = trackedEntityInstance;

    await this.save();

    // final reservedAttributes = await AttributeReservedValueQuery().where(attribute: attribute, value: value)

    return trackedEntityInstance;
  }

  Future<List<Event>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<Event> events = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    List<String> eventIds = [];
    List<String> eventProgramStageIds = [];
    events.forEach((event) {
      eventIds.add(event.id as String);

      eventProgramStageIds.removeWhere((id) => id == event.programStage);
      eventProgramStageIds.add(event.programStage);
    });

    List<EventDataValue> eventDataValues = await EventDataValueQuery()
        .whereIn(attribute: 'event', values: eventIds, merge: false)
        .get();

    List<ProgramStage> programStages =
        await ProgramStageQuery().byIds(eventProgramStageIds).get();

    final eventUploadPayload = events.map((event) {
      event.dataValues = eventDataValues
          .where((dataValue) => dataValue.event == event.id)
          .toList();
      event.programStage = programStages
          .lastWhere((programStage) => programStage.id == event.programStage)
          .toJson();
      return Event.toUpload(event);
    }).toList();

    final response = await HttpClient.post(
        this.apiResourceName as String, {'events': eventUploadPayload},
        database: this.database, dioTestClient: dioTestClient);

    final List<dynamic> importSummaries =
        (response.body?['response']?['importSummaries'] ?? []).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    events.forEach((event) {
      final importSummary = importSummaries.lastWhere((summary) =>
          summary['reference'] != null && summary['reference'] == event.id);

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        event.synced = !syncFailed;
        event.dirty = syncFailed;
        event.syncFailed = syncFailed;
        event.lastSyncDate = DateTime.now().toIso8601String();
        event.lastSyncSummary = importSummary.toString();
        queue.add(() => EventQuery().setData(event).save());
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return await EventQuery().byIds(eventIds).get();
  }
}

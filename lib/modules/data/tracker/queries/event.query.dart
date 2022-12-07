import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/event_import_summary.dart';
import 'package:d2_touch/modules/data/tracker/queries/event_data_value.query.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class EventQuery extends BaseQuery<Event> {
  String? orgUnit;
  String? program;
  String? programStage;
  String? enrollment;

  EventQuery({Database? database}) : super(database: database);

  EventQuery withDataValues() {
    final eventDataValue =
        Repository<EventDataValue>(database: database as Database);

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
    return this.where(attribute: 'orgUnit', value: orgUnit);
  }

  EventQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  EventQuery byProgramStage(String programStage) {
    this.programStage = programStage;
    return this.where(attribute: 'programStage', value: programStage);
  }

  EventQuery byEnrollment(String enrollment) {
    this.enrollment = enrollment;
    return this.where(attribute: 'enrollment', value: enrollment);
  }

  @override
  Future<String> dhisUrl() {
    return Future.value(
        'events.json?fields=event,eventDate,dueDate,program,programStage,orgUnit,trackedEntityInstance,enrollment,enrollmentStatus,status,attributeCategoryOptions,lastUpdated,created,followup,deleted,attributeOptionCombo,dataValues[dataElement,value,lastUpdated,created,storedBy,providedElseWhere]&orgUnit=${this.orgUnit}&program=${this.program}${this.programStage != null ? '&programStage=${this.programStage}' : ''}&order=eventDate:desc&pageSize=100&page=1');
  }

  @override
  Future create() async {
    Event event = Event(
        orgUnit: this.orgUnit as String,
        status: 'ACTIVE',
        enrollment: this.enrollment,
        dirty: true,
        synced: false,
        programStage: this.programStage,
        eventDate: DateTime.now().toIso8601String().split(".")[0]);

    this.data = event;

    await this.save();

    return event;
  }

  Future<List<Event>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<Event> events = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${events.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${events.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    List<String> eventIds = [];
    List<String> eventProgramStageIds = [];
    events.forEach((event) {
      eventIds.add(event.id as String);

      eventProgramStageIds.removeWhere((id) => id == event.programStage);
      eventProgramStageIds.add(event.programStage);
    });

    List<EventDataValue> eventDataValues =
        await EventDataValueQuery(database: database)
            .whereIn(attribute: 'event', values: eventIds, merge: false)
            .get();

    List<ProgramStage> programStages =
        await ProgramStageQuery(database: database)
            .byIds(eventProgramStageIds)
            .get();

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

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${events.length} ${this.apiResourceName?.toLowerCase()} is completed.',
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

    events.forEach((event) {
      final importSummary = importSummaries.lastWhere((summary) =>
          summary['reference'] != null && summary['reference'] == event.id);

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        event.synced = !syncFailed;
        event.dirty = true;
        event.syncFailed = syncFailed;
        event.lastSyncDate = DateTime.now().toIso8601String().split('.')[0];
        event.lastSyncSummary = EventImportSummary.fromJson(importSummary);
        queue.add(() => EventQuery(database: database).setData(event).save());
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

    return await EventQuery(database: database).byIds(eventIds).get();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}

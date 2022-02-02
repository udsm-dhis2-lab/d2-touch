import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/event_data_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_stage.query.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class EventQuery extends BaseQuery<Event> {
  EventQuery({Database? database}) : super(database: database);

  Future<List<Event>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<Event> events = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    List<String> eventIds = [];
    List<String> eventProgramStageIds = [];
    events.forEach((event) {
      eventIds.add(event.id);

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

import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class EnrollmentQuery extends BaseQuery<Enrollment> {
  EnrollmentQuery({Database? database}) : super(database: database);

  Future<List<Enrollment>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<Enrollment> enrollments = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    final List<String> enrollmentIds = enrollments
        .map((trackedEntityInstance) => trackedEntityInstance.id)
        .toList();

    final enrollmentUploadPayload = enrollments.map((enrollment) {
      return Enrollment.toUpload(enrollment);
    }).toList();

    final response = await HttpClient.post(this.apiResourceName as String,
        {'enrollments': enrollmentUploadPayload},
        database: this.database, dioTestClient: dioTestClient);

    final List<dynamic> importSummaries =
        (response.body?['response']?['importSummaries'] ?? []).toList();

    print(json.encode({'enrollments': enrollmentUploadPayload}));

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    enrollments.forEach((enrollment) {
      final importSummary = importSummaries.lastWhere((summary) =>
          summary['reference'] != null &&
          summary['reference'] == enrollment.id);

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        enrollment.synced = !syncFailed;
        enrollment.dirty = syncFailed;
        enrollment.syncFailed = syncFailed;
        enrollment.lastSyncDate = DateTime.now().toIso8601String();
        enrollment.lastSyncSummary = importSummary.toString();
        queue.add(() => EnrollmentQuery().setData(enrollment).save());
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return await EnrollmentQuery().byIds(enrollmentIds).get();
  }
}

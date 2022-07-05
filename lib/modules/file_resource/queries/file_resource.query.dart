import 'dart:convert';

import 'package:d2_touch/modules/file_resource/entities/file_resource.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class FileResourceQuery extends BaseQuery<FileResource> {
  FileResourceQuery({Database? database}) : super(database: database);

  Future<List<FileResource>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<FileResource> fileResources =
        await this.where(attribute: 'synced', value: false).get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${fileResources.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${fileResources.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    // final response = await HttpClient.post(this.apiResourceName as String,
    //     {'trackedEntityInstances': trackedEntityInstanceUploadPayload},
    //     database: this.database, dioTestClient: dioTestClient);

    final uploadQueue = Queue(parallel: 50);
    num availableUploadItemCount = 0;
    List fileResourceResponses = [];

    fileResources.forEach((fileResource) async {
      availableUploadItemCount++;

      var formData = FormData.fromMap(
          {'file': await MultipartFile.fromFile(fileResource.localFilePath)});
      uploadQueue.add(() async {
        final fileResourceResponse = await HttpClient.post(
            this.apiResourceName as String, formData,
            database: this.database, dioTestClient: dioTestClient);
        fileResourceResponses.add({
          'fileResourceId': fileResource.id,
          'fileResourceResponse': fileResourceResponse.body
        });
        return fileResourceResponse;
      });
    });

    if (availableUploadItemCount == 0) {
      uploadQueue.cancel();
    } else {
      await uploadQueue.onComplete;
    }

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${fileResources.length} ${this.apiResourceName?.toLowerCase()} is completed.',
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

    final List<dynamic> importSummaries = ([]).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    fileResources.forEach((fileResource) {
      final fileResourceResponse = fileResourceResponses.lastWhere(
          (response) => response['fileResourceId'] == fileResource.id,
          orElse: (() => null));

      if (fileResourceResponse != null) {
        final importSummary = fileResourceResponse['fileResourceResponse'];
        availableItemCount++;

        final syncFailed = importSummary['status'] != 'OK';
        fileResource.synced = !syncFailed;
        fileResource.dirty = true;
        fileResource.syncFailed = syncFailed;
        fileResource.resourceId =
            importSummary['response']?['fileResource']?['id'];
        fileResource.storageStatus =
            importSummary['response']?['fileResource']?['storageStatus'];
        fileResource.lastSyncDate =
            DateTime.now().toIso8601String().split('.')[0];
        fileResource.lastSyncSummary = importSummary.toString();
        queue.add(() => FileResourceQuery().setData(fileResource).save());
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

    return await FileResourceQuery()
        .byIds(fileResources
            .map((fileResource) => fileResource.id as String)
            .toList())
        .get();
  }
}

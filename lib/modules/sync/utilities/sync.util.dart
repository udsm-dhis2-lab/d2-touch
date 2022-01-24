import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/sync/models/error_message.model.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/modules/sync/utilities/query-resource.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class Sync {
  List<RequestProgress>? requestProgresses;
  late bool metadataSyncInProgress;
  bool? isDbOperationInitiated;
  ErrorMessage? finalError;

  Sync() {
    this.metadataSyncInProgress = false;
  }

  download(
      {required Function(List<RequestProgress>?, bool, dynamic) callback,
      Database? database}) async {
    if (!this.metadataSyncInProgress) {
      this.metadataSyncInProgress = true;

      try {
        List<QueryResource> queryResources = QueryResource.getQueryResources(
            currentUser: null, database: database);

        List<RequestProgress> requestProgresses =
            queryResources.map((QueryResource queryResource) {
          return RequestProgress(
              resourceName: queryResource.name,
              message:
                  'Downloading ${queryResource.name.toUpperCase()} from the server',
              status: '',
              percentage: 0);
        }).toList();

        final queue = Queue(parallel: 2);

        queryResources.forEach((queryResource) {
          queue.add(() => HttpClient.get(queryResource.dhisUrl));
        });

        final complete = await queue.onComplete;

        callback(requestProgresses, false, null);
      } catch (e) {
        callback(null, false, e);
      }
    }
  }

  Future<dynamic> _fetchData() async {}
}

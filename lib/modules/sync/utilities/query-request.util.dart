import 'package:dhis2_flutter_sdk/modules/sync/utilities/dhis-url-generator.util.dart';
import 'package:dhis2_flutter_sdk/modules/sync/utilities/query-resource.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_model.util.dart';

class QueryRequest {
  QueryModel? query;
  String? resourceName;
  String? loadingMessage;
  String? loadedMessage;

  QueryRequest(
      {required this.query,
      required this.resourceName,
      this.loadingMessage,
      this.loadedMessage});

  String get url {
    return DhisUrlGenerator.generate(this.query);
  }

  static List<QueryRequest> getQueryRequests(
      List<QueryResource> queryResources) {
    return [];
  }
}

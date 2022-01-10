import 'package:dhis2_flutter_sdk/shared/utilities/query_model.util.dart';

import 'query-resource.model.dart';

class QueryRequest {
  QueryModel? query;
  String? resourceName;
  String? loadingMessage;
  String? loadedMessage;

  QueryRequest(
      {required query,
      required String resourceName,
      required String loadingMessage,
      required String loadedMessage});

  String get url {
    return '';
  }

  static List<QueryRequest> getQueryRequests(
      List<QueryResource> queryResources) {
    print(queryResources);
    return queryResources
        .map((QueryResource queryResources) => QueryRequest(
            query: '', resourceName: '', loadingMessage: '', loadedMessage: ''))
        .toList();

    // return queryResources.map((queryResource: QueryResource) => {
    //   return {
    //     url: generateUrl(queryResource.query),
    //     resourceName: queryResource.name,
    //     loadingMessage: "",
    //     loadedMessage: "",
    //   };
    // });
  }
}

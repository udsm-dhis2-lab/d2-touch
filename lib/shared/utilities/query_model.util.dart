import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:flutter/foundation.dart';

class QueryModel {
  String resourceName;
  String singularResourceName;
  String tableName;
  String id;
  List<String> fields;
  List<QueryFilter> filters;
  dynamic relations;

  QueryModel(
      {@required this.resourceName,
      this.singularResourceName,
      @required this.tableName,
      this.id,
      this.fields,
      this.filters,
      this.relations});
}

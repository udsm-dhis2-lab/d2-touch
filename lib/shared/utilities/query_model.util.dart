import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';

class QueryModel {
  String resourceName;
  String tableName;
  String? singularResourceName;
  String? id;
  List<String>? fields;
  List<QueryFilter>? filters;
  dynamic relations;

  QueryModel(
      {required this.resourceName,
      required this.tableName,
      this.singularResourceName,
      this.id,
      this.fields,
      this.filters,
      this.relations});
}

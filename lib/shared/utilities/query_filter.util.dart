import 'package:dhis2_flutter_sdk/shared/utilities/query_filter_condition.util.dart';
import 'package:flutter/foundation.dart';

class QueryFilter {
  String attribute;
  QueryCondition condition;
  dynamic value;
  QueryFilter(
      {required this.attribute, required this.condition, required this.value});

  static String? getWhereParameters(List<QueryFilter>? filters) {
    if (filters == null) {
      return null;
    }

    final whereParams = filters.map((filter) {
      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return '${filter.attribute} IN (${values.map((value) => '"$value"').join(',')})';

        case QueryCondition.Equal:
          return '${filter.attribute} = ${filter.value}';

        case QueryCondition.Like:
          return '${filter.attribute} LIKE ${filter.value}';

        case QueryCondition.LessThan:
          return '${filter.attribute} < ${filter.value}';

        case QueryCondition.LessThanOrEqualTo:
          return '${filter.attribute} <= ${filter.value}';
        case QueryCondition.GreaterThan:
          return '${filter.attribute} > ${filter.value}';

        case QueryCondition.GreaterThanOrEqualTo:
          return '${filter.attribute} >= ${filter.value}';
        default:
          return null;
      }
    }).where((filter) => filter != null);

    return whereParams.length > 0 ? whereParams.join(' AND ') : null;
  }
}

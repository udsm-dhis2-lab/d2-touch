import 'package:dhis2_flutter_sdk/shared/utilities/query_filter_condition.util.dart';
import 'package:flutter/foundation.dart';

class QueryFilter {
  String attribute;
  QueryCondition condition;
  dynamic value;
  QueryFilter(
      {@required this.attribute,
      @required this.condition,
      @required this.value});

  static String getWhereParameters(List<QueryFilter> filters) {
    if (filters == null) {
      return null;
    }

    return filters.map((filter) {
      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return '${filter.attribute} IN (${values.map((value) => '"$value"').join(',')})';

        case QueryCondition.Equal:
          return '${filter.attribute} = ${filter.value}';
          break;
        case QueryCondition.Ilike:
          return '${filter.attribute} ILIKE ${filter.value}';
          break;
        case QueryCondition.LessThan:
          return '${filter.attribute} < ${filter.value}';
          break;
        case QueryCondition.LessThanOrEqualTo:
          // TODO: Handle this case.
          break;
        case QueryCondition.GreaterThan:
          return '${filter.attribute} > ${filter.value}';
          break;
        case QueryCondition.GreaterThanOrEqualTo:
          // TODO: Handle this case.
          break;
        default:
          return '';
      }
    }).join(' AND ');
  }
}

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/utilities/query_filter_condition.util.dart';

class QueryFilter {
  String attribute;
  QueryCondition condition;
  dynamic value;
  QueryFilter(
      {required this.attribute, required this.condition, required this.value});

  static String? getWhereParameters(
      List<Column> columns, List<QueryFilter>? filters) {
    if (filters == null) {
      return null;
    }

    final whereParams = filters.map((filter) {
      final Column attributeColumn = columns
          .lastWhere((column) => column.attributeName == filter.attribute);

      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return '${filter.attribute} IN (${values.map((value) => '${QueryFilter.getTypedValue(attributeColumn, value)}').join(',')})';

        case QueryCondition.Equal:
          return '${filter.attribute} = ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.Like:
          return '${filter.attribute} LIKE ${QueryFilter.getTypedValue(attributeColumn, filter.value, isLikeFilter: true)}';

        case QueryCondition.LessThan:
          return '${filter.attribute} < ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.LessThanOrEqualTo:
          return '${filter.attribute} <= ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';
        case QueryCondition.GreaterThan:
          return '${filter.attribute} > ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.GreaterThanOrEqualTo:
          return '${filter.attribute} >= ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';
        default:
          return null;
      }
    }).where((filter) => filter != null);

    return whereParams.length > 0 ? whereParams.join(' AND ') : null;
  }

  static String? getApiFilters(
      List<Column> columns, List<QueryFilter>? filters) {
    if (filters == null) {
      return null;
    }

    final whereParams = filters.map((filter) {
      final Column attributeColumn = columns
          .lastWhere((column) => column.attributeName == filter.attribute);

      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return 'filter=${filter.attribute}${attributeColumn.relation?.referencedColumn != null ? '.${attributeColumn.relation?.referencedColumn}' : ''}:in:[${values.join(',')}]';

        case QueryCondition.Equal:
          return 'filter=${filter.attribute}:eq:${filter.value}';

        case QueryCondition.Like:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          final ilikeFilters = values
              .map((valueItem) => 'filter=${filter.attribute}:like:$valueItem')
              .toList();
          return ilikeFilters.join('&') + '&rootJunction=OR';

        case QueryCondition.Ilike:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          final ilikeFilters = values
              .map((valueItem) => 'filter=${filter.attribute}:ilike:$valueItem')
              .toList();
          return ilikeFilters.join('&') + '&rootJunction=OR';

        case QueryCondition.LessThan:
          return 'filter=${filter.attribute}:lt:${filter.value}';

        case QueryCondition.LessThanOrEqualTo:
          return 'filter=${filter.attribute}:lte:${filter.value}';
        case QueryCondition.GreaterThan:
          return 'filter=${filter.attribute}:gt:${filter.value}';

        case QueryCondition.GreaterThanOrEqualTo:
          return 'filter=${filter.attribute}:gte:${filter.value}';
        default:
          return null;
      }
    }).where((filter) => filter != null);

    return whereParams.length > 0 ? whereParams.join(' AND ') : null;
  }

  static getTypedValue(Column attributeColumn, dynamic value,
      {bool? isLikeFilter}) {
    switch (attributeColumn.columnType) {
      case 'TEXT':
        return isLikeFilter != null && isLikeFilter == true
            ? '"%$value%"'
            : '"$value"';
      case 'BOOLEAN':
        return value == true ? 1 : 0;
      default:
        return value;
    }
  }
}

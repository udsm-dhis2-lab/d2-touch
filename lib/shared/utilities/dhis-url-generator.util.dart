import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_model.util.dart';

class DhisUrlGenerator {
  static String generate(QueryModel? query) {
    if (query == null) {
      return '';
    }

    final filters = getFilterParams([]);

    return '${query.resourceName}.json?fields=${query.fields?.join(',')}${filters != '' ? '&' + filters : ''}&paging=false';
  }

  static getRelationFields(relations) {
    return relations.map((relation) {
      // return `${relation.resourceName}[${[
      //   ...relation.fields,
      //   ...getRelationFields(relation.relations),
      // ].join(',')}]`;
    });
  }

  static getFilterParams(List<QueryFilter> queryFilters) {
    return queryFilters.map((QueryFilter filter) =>
        // `filter=${filter.attribute}:${filter.condition}:${sanitizeFilterValue(
        //   filter.value,
        //   filter.condition
        // )}`
        '').join('&');
  }

  static String sanitizeFilterValue(
      dynamic filterValue, String filterCondition) {
    switch (filterCondition) {
      // case QueryFilterCondition.IN:
      case '':
        // return `[${filterValue.join(',')}]`;
        return '';
      default:
        return filterValue;
    }
  }
}

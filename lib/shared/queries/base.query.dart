import 'package:dhis2_flutter_sdk/core/repository.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_filter_condition.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_model.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/save_option.util.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/sort_order.util.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class BaseQuery<T extends BaseEntity> {
  Database database;
  Repository repository;
  dynamic data;
  List<String> fields;
  String tableName;
  String resourceName;
  String singularResourceName;
  String id;
  List<QueryFilter> filters = [];
  Map<String, SortOrder> sortOrder = {};
  List<dynamic> relations;

  BaseQuery({Database database}) {
    this.database = database;
    this.repository = Repository<T>();
    this.tableName = repository.entity.tableName;
    this.fields = repository.columns.map((column) => column.name).toList();
  }

  select(List<String> fields) {
    this.fields = fields;
    return this;
  }

  byId(String id) {
    this.id = id;
    this.filters = null;
    return this;
  }

  byIds(List<String> ids) {
    this.id = null;
    return this.whereIn(attribute: 'id', values: ids, merge: false);
  }

  whereIn(
      {@required String attribute, @required List<String> values, bool merge}) {
    if (merge) {
      this.filters.add(QueryFilter(
          attribute: attribute, condition: QueryCondition.In, value: values));
    } else {
      this.filters = [
        QueryFilter(
            attribute: attribute, condition: QueryCondition.In, value: values)
      ];
    }

    return this;
  }

  where({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute, condition: QueryCondition.Equal, value: value));

    return this;
  }

  like({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute, condition: QueryCondition.Like, value: value));
    return this;
  }

  greaterThan({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.GreaterThan,
        value: value));
    return this;
  }

  greaterThanOrEqual({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.GreaterThanOrEqualTo,
        value: value));
    return this;
  }

  lessThan({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.LessThan,
        value: value));
    return this;
  }

  lessThanOrEqual({@required String attribute, @required dynamic value}) {
    this.filters.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.LessThanOrEqualTo,
        value: value));
    return this;
  }

  orderBy({@required String attribute, @required SortOrder order}) {
    this.sortOrder[attribute] = order;
    return this;
  }

  setData(dynamic data) {
    this.data = data;
    return this;
  }

  QueryModel getQuery() {
    return QueryModel(
        resourceName: this.resourceName,
        tableName: this.tableName,
        singularResourceName: this.singularResourceName,
        fields: this.fields,
        filters: this.filters,
        relations: this.relations);
  }

  Future<List<T>> get() async {
    if (this.id != null) {
      return this
          .repository
          .find(id: this.id, fields: this.fields, database: this.database);
    }

    return this.repository.findAll(
        database: this.database,
        filters: this.filters,
        fields: this.fields,
        sortOrder: this.sortOrder);
  }

  Future<T> getOne() async {
    List<T> results = await this.get();

    return results.length > 0 ? results[0] : null;
  }

  Future<int> save({SaveOptions saveOptions}) {
    if (this.data is List) {
      return this
          .repository
          .saveMany(entities: this.data as List<T>, database: this.database);
    }

    return this
        .repository
        .saveOne(entity: this.data as T, database: this.database);
  }

  Future delete() {
    if (this.id != null) {
      return this.repository.deleteById(id: this.id, database: this.database);
    }

    return this.repository.deleteAll();
  }

  Future createTable() {
    return this.repository.create(database: this.database);
  }

  Future count() {
    throw UnimplementedError();
  }

  Future create() {
    return this.repository.create(database: database);
  }
}

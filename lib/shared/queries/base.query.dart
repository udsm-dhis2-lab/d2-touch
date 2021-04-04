import 'package:dhis2_flutter_sdk/core/annotations/column.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/relation.annotation.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:dhis2_flutter_sdk/core/repository.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseQuery<T> {
  dynamic data;
  List<String> fields;
  String id;

  // BaseQuery() {}

  String get resourceName {
    throw ('Not implemented');
  }

  String get daoName {
    throw ('Not implemented');
  }

  select(List<String> fields) {
    this.fields = fields;
    return this;
  }

  byId(String id) {
    this.id = id;
    return this;
  }

  setData(dynamic data) {
    this.data = data;
    return this;
  }

  Future<Database> get database {
    return DatabaseManager.instance.database;
  }

  Future get() async {
    final repository = Repository<T>();
    // return await this.database;
  }

  Future save() async {}

  Future createTable(String name, columnsArray) async {
    String columns = columnsArray.join(', ');
    columns = columns.replaceAll("MAP", "BLOB");
    final query = "CREATE TABLE IF NOT EXISTS $name ($columns)";
    var dbClient = await database;
    return await dbClient.execute(query);
  }
}

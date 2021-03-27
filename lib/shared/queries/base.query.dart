import 'package:dhis2_flutter_sdk/core/annotations/column.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/relation.annotation.dart';
import 'package:dhis2_flutter_sdk/core/database/database_manager.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseQuery<T> {
  dynamic data;
  List<String> fields;
  String id;

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
    print(getTableColumnDefinitions<T>());
    return await this.database;
  }

  Future save() async {
    // final dynamic database = await this.database;
    // final dynamic dao = database[this.daoName];

    // if (this.id != null) {
    //   return dao.updateOne(this.data as T);
    // }

    // return dao.updateMany(this.data as List<T>);
  }

  // Future<List<dynamic>> downloadData(String url, String attribute) async {
  //   final dynamic responseData = await HttpService.get(url);

  //   if (this.id != null) {
  //     return responseData;
  //   }
  //   return responseData[attribute];
  // }

  Future createTable(String name, columnsArray) async {
    String columns = columnsArray.join(', ');
    columns = columns.replaceAll("MAP", "BLOB");
    final query = "CREATE TABLE IF NOT EXISTS $name ($columns)";
    var dbClient = await database;
    return await dbClient.execute(query);
  }

  Map<String, List<String>> getTableColumnDefinitions<T>({Type type}) {
    ClassMirror classMirror;
    if (type != null) {
      classMirror = AnnotationReflectable.reflectType(type);
    } else {
      classMirror = AnnotationReflectable.reflectType(T);
    }
    Map<String, List<String>> tables = {};
    List<String> columns = [];
    for (String key in classMirror.declarations.keys) {
      var value = classMirror.declarations[key];
      if (value is VariableMirror) {
        VariableMirror variableMirror = value;
        bool isPrimaryKey = false;
        variableMirror.metadata.forEach((element) {
          if (element is PrimaryColumn) {
            columns.add('$key TEXT PRIMARY KEY');
            isPrimaryKey = true;
          }
        });
        if (!isPrimaryKey) {
          if (variableMirror.reflectedType == String) {
            columns.add('$key TEXT');
          } else if (variableMirror.reflectedType == int) {
            columns.add('$key INTEGER');
          } else if (variableMirror.reflectedType == bool) {
            columns.add('$key BOOLEAN');
          } else {
            variableMirror.metadata.forEach((element) {
              if (element is Column) {
                columns.add('$key TEXT');
              } else if (element is OneToOne) {
                Map<String, List<String>> tempTables =
                    getTableColumnDefinitions(
                        type: variableMirror.reflectedType);
                tables.addAll(tempTables);
              } else {}
            });
          }
        }
      }
    }
    columns.add('isdirty BOOLEAN');
    tables[classMirror.simpleName.toLowerCase()] = columns;
    return tables;
  }
}

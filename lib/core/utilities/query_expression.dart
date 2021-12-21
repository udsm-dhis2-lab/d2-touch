import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:flutter/foundation.dart';

import '../annotations/column.annotation.dart';

class QueryExpression {
  static String getColumnExpression(
      {String name, String type, bool primary, bool nullable}) {
    return '$name $type${primary ? ' PRIMARY KEY' : ''}${nullable ? '' : ' NOT NULL'}';
  }

  static String getCreateTableExpression(
      String tableName, List<Column> columns) {
    List<String> columnsQueryExpressions = [];
    List<String> referencedCreateTableExpressions = [];
    List<String> foreignKeyContraints = [];
    columns.forEach((column) {
      if (column?.relation?.relationType != RelationType.OneToMany) {
        columnsQueryExpressions.add(column.columnQueryExpresion);
      }

      if (column.relation != null &&
          column.relation.relationType == RelationType.ManyToOne) {
        referencedCreateTableExpressions.add(
            QueryExpression.getCreateTableExpression(
                column.relation.referencedEntity.tableName,
                column.relation.referencedEntityColumns));

        foreignKeyContraints.add(
            QueryExpression.getForeignKeyConstrainExpression(
                foreignColumn: column.name,
                referencedColumn: column.relation.referencedColumn,
                referencedTable: column.relation.referencedEntity.tableName));
      }
    });

    final String columnsQueryExpression = columnsQueryExpressions.join(', ');
    final String foreignKeyExpression = foreignKeyContraints.length > 0
        ? ', ' + foreignKeyContraints.join(', ')
        : '';
    final String referencedTableExpression =
        referencedCreateTableExpressions.length > 0
            ? referencedCreateTableExpressions.join(';') + ';'
            : '';

    return '${referencedTableExpression}CREATE TABLE IF NOT EXISTS $tableName ($columnsQueryExpression$foreignKeyExpression)';
  }

  static String getForeignKeyConstrainExpression(
      {String foreignColumn, String referencedTable, String referencedColumn}) {
    return 'FOREIGN KEY ($foreignColumn) REFERENCES $referencedTable ($referencedColumn)';
  }

  static getSelectExpression({@required Entity entity, List<String> columns}) {
    final String columnExpression =
        QueryExpression.getSelectColumnExpression(columns);

    return 'SELECT $columnExpression FROM ${entity.tableName}';
  }

  static getSelectColumnExpression(List<String> columns) {
    return columns != null && columns.length > 0
        ? columns.join(',').toString()
        : '*';
  }
}

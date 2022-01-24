import 'package:dhis2_flutter_sdk/core/annotations/index.dart';

class QueryExpression {
  static String getColumnExpression(
      {required String name,
      required String type,
      required bool primary,
      required bool nullable}) {
    return '$name $type${primary ? ' PRIMARY KEY' : ''}${nullable ? '' : ' NOT NULL'}';
  }

  static String getCreateTableExpression(
      String tableName, List<Column> columns) {
    List<String> columnsQueryExpressions = [];
    List<String> referencedCreateTableExpressions = [];
    List<String> foreignKeyContraints = [];
    columns.forEach((column) {
      if (column.relation?.relationType != RelationType.OneToMany) {
        columnsQueryExpressions.add(column.columnQueryExpresion);
      }

      if (column.relation != null &&
          column.relation?.relationType == RelationType.ManyToOne) {
        referencedCreateTableExpressions.add(
            QueryExpression.getCreateTableExpression(
                column.relation!.referencedEntity!.tableName,
                column.relation!.referencedEntityColumns as List<Column>));

        foreignKeyContraints.add(
            QueryExpression.getForeignKeyConstrainExpression(
                foreignColumn: column.name as String,
                referencedColumn: column.relation!.referencedColumn as String,
                referencedTable: column.relation!.referencedEntity!.tableName));
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
      {required String foreignColumn,
      required String referencedTable,
      required String referencedColumn}) {
    return 'FOREIGN KEY ($foreignColumn) REFERENCES $referencedTable ($referencedColumn)';
  }

  static getSelectExpression(
      {required Entity entity, required List<String> columns}) {
    final String columnExpression =
        QueryExpression.getSelectColumnExpression(columns);

    return 'SELECT $columnExpression FROM ${entity.tableName}';
  }

  static getSelectColumnExpression(List<String> columns) {
    return columns.length > 0 ? columns.join(',').toString() : '*';
  }
}

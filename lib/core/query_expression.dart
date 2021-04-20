import 'annotations/column.annotation.dart';

class QueryExpression {
  static String getColumnExpression(
      {String name, String type, bool primary, bool nullable}) {
    return '$name $type${primary ? ' PRIMARY KEY' : ''}${nullable ? '' : ' NOT NULL'}';
  }

  static String getCreateTableExpression(
      String tableName, List<Column> columns) {
    final String columnsQueryExpression =
        columns.map((column) => column.columnQueryExpresion).join(', ');
    return 'CREATE TABLE IF NOT EXISTS $tableName ($columnsQueryExpression)';
  }
}

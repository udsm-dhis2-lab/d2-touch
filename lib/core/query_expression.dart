class QueryExpression {
  static String getColumnExpression(
      {String name, String type, bool primary, bool nullable}) {
    return '$name $type${primary ? ' PRIMARY KEY' : ''}${nullable ? '' : ' NOT NULL'}';
  }

  static String getCreateTableExpression({String tableName}) {
    return 'CREATE TABLE IF NOT EXISTS $tableName';
  }
}

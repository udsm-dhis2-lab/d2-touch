import 'package:async/async.dart';

import 'database_config.dart';

class DatabaseManager {
  final String databaseName = 'flutter_database.db';
  static final DatabaseManager _databaseInstance =
      new DatabaseManager._internal();
  static AppDatabaseConfig _database;
  final _initDatabaseMemoizer = AsyncMemoizer<AppDatabaseConfig>();

  factory DatabaseManager() {
    return _databaseInstance;
  }

  DatabaseManager._internal();

  static DatabaseManager get instance => _databaseInstance;

  Future<AppDatabaseConfig> get database async {
    if (_database != null) {
      return _database;
    }

    return await _initDatabaseMemoizer.runOnce(() async {
      return await $FloorAppDatabaseConfig
          .databaseBuilder(this.databaseName)
          .build();
    });
  }
}

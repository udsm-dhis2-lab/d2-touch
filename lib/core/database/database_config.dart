// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database_config.g.dart'; // the generated code will be there

@Database(version: 1, entities: [])
abstract class AppDatabaseConfig extends FloorDatabase {}

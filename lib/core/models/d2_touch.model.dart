import 'package:d2_touch/modules/auth/user.module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

abstract class D2TouchModel {
  String locale = 'en';
  Database? database;
  bool? inMemory;
  DatabaseFactory? databaseFactory;
  late SharedPreferences sharedPreferenceInstance;

  Future<Database> setDatabase({
    required String databaseName,
    bool? inMemory,
    DatabaseFactory? databaseFactory,
    required SharedPreferences sharedPreferenceInstance,
  });

  UserModule get userModule2;
}

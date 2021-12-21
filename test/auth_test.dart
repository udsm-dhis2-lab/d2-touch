import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/models/login-response.model.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/user.module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'auth_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(databaseFactory: databaseFactoryFfi);

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  UserQuery userQuery = UserQuery(database: db);

  List<User> users;
  try {
    users = await userQuery.get();
  } catch (e) {}

  test('should not initialize database if no database name is supplied', () {
    expect(users, null);
  });

  final isAuthenticated = await D2Touch.isAuthenticated(
      sharedPreferenceInstance: SharedPreferences.getInstance());

  test('should not be authenticated if database is not set', () {
    expect(isAuthenticated, false);
  });

  final onlineLogIn = await D2Touch.logIn(
    username: 'admin',
    password: 'district',
    url: 'https://play.dhis2.org/2.35.9',
    databaseFactory: databaseFactoryFfi,
  );

  test('should successfully authenticate user on online login', () {
    expect(onlineLogIn, LoginResponseStatus.ONLINE_LOGIN_SUCCESS);
  });

  final logOutResponse = await D2Touch.logOut();

  final isAuthenticatedAfterLogout = await D2Touch.isAuthenticated(
      sharedPreferenceInstance: SharedPreferences.getInstance());

  test('should successfully log out user', () {
    expect(logOutResponse, true);
    expect(isAuthenticatedAfterLogout, false);
  });
}

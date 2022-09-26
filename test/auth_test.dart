import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/user/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/user/models/login-response.model.dart';
import 'package:d2_touch/modules/auth/user/queries/user.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'auth_test.reflectable.dart';

import '../sample/current_user.sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(databaseFactory: databaseFactoryFfi);

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  UserQuery userQuery = UserQuery(database: db);

  List<User?>? users;
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

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(200, userData),
  );

  final onlineLogIn = await D2Touch.logIn(
      username: 'admin',
      password: 'district',
      url: 'https://play.dhis2.org/2.35.11',
      databaseFactory: databaseFactoryFfi,
      dioTestClient: dio);

  final user =
      await D2Touch.userModule.user.withAuthorities().withRoles().getOne();

  // test('should successfully authenticate user on online login', () {
  //   expect(onlineLogIn, LoginResponseStatus.ONLINE_LOGIN_SUCCESS);
  // });

  // test('should return appropriate user roles for a user', () {
  //   expect(user?.roles?.length, 13);
  // });

  // final logOutResponse = await D2Touch.logOut();

  // final isAuthenticatedAfterLogout = await D2Touch.isAuthenticated(
  //     sharedPreferenceInstance: SharedPreferences.getInstance());

  // test('should successfully log out user', () {
  //   expect(logOutResponse, true);
  //   expect(isAuthenticatedAfterLogout, false);
  // });
}

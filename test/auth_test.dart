import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/models/login-response.model.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/auth-token.sample.dart';
import 'auth_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
      sharedPreferenceInstance: sharedPreferenceInstance,
      databaseFactory: databaseFactory);

  final isAuthenticated = await d2.authModule.isAuthenticated();

  test('should not be authenticated if database is not set', () {
    expect(isAuthenticated, false);
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,phoneNumber,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(200, userData),
  );

  final onlineLogIn = await d2.authModule.logIn(
      username: 'admin',
      password: 'district',
      url: 'https://play.dhis2.org/2.35.11',
      dioTestClient: dio);

  final user = await d2.userModule2.user.withAuthorities().withRoles().getOne();

  test('should successfully authenticate user on online login', () {
    expect(onlineLogIn, LoginResponseStatus.ONLINE_LOGIN_SUCCESS);
  });

  test('should return appropriate user roles for a user', () {
    expect(user?.roles?.length, 13);
  });

  final logOutResponse = await d2.authModule.logOut();

  final isAuthenticatedAfterLogout = await d2.authModule.isAuthenticated();

  test('should successfully log out user', () {
    expect(logOutResponse, true);
    expect(isAuthenticatedAfterLogout, false);
  });

  await d2.dispose();
  final d2TokenBased = await D2Touch.init(
      sharedPreferenceInstance: sharedPreferenceInstance,
      databaseFactory: databaseFactory);

  // print((await d2TokenBased.userModule2.user.getOne())?.toJson());

  // await d2TokenBased.authModule.setToken(
  //     instanceUrl: 'https://dev.dhis2.udsm.ac.tz',
  //     userObject: userData,
  //     tokenObject: wrongSampleAuthToken);

  // User? userWithToken = await d2TokenBased.userModule2.user.getOne();

  // test('should get user information with authentication token', () async {
  //   expect(userWithToken, isNotNull);
  //   expect(userWithToken?.token, '6NK1ZJIWakbVaftAQnigzWgue98');
  //   expect(userWithToken?.tokenType, 'bearer');
  // });

  // print(userWithToken?.toJson());
}

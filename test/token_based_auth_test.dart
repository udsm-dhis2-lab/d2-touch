import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../sample/auth-token.sample.dart';
import '../sample/current_user.sample.dart';
import 'token_based_auth_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  await D2Touch.setToken(
      instanceUrl: 'https://dev.dhis2.udsm.ac.tz',
      userObject: userData,
      tokenObject: wrongSampleAuthToken);

  UserQuery userQuery = UserQuery(database: db);

  User? user = await userQuery.getOne();

  test('should get user information with authentication token', () async {
    expect(user, isNotNull);
    expect(user?.token, '6NK1ZJIWakbVaftAQnigzWgue98');
    expect(user?.tokenType, 'bearer');
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://dev.dhis2.udsm.ac.tz/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(401,
        '<InvalidTokenException><error>invalid_token</error><error_description>Invalid access token: 6NK1ZJIWakbVaftAQnigzWgue98</error_description></InvalidTokenException>'),
  );

  final invalidTokenResponse = await HttpClient.get(
      'me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
      dioTestClient: dio);

  test("should return error message and status for invalid token", () {
    expect(invalidTokenResponse.statusCode, 401);
    expect(invalidTokenResponse.body['InvalidTokenException']['error'],
        'invalid_token');
  });

// Setting correct token
  await D2Touch.setToken(
      instanceUrl: 'https://dev.dhis2.udsm.ac.tz',
      userObject: userData,
      tokenObject: correctSampleAuthToken);

  User? userWithCorrectToken = await UserQuery().getOne();

  test('should get user information with correct authentication token',
      () async {
    expect(userWithCorrectToken, isNotNull);
    expect(userWithCorrectToken?.token, '6NK1ZJIWakbVaftAQ78gzWgue98');
    expect(userWithCorrectToken?.tokenType, 'bearer');
  });

  dioAdapter.onGet(
    'https://dev.dhis2.udsm.ac.tz/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(200, userData),
  );

  final validTokenResponse = await HttpClient.get(
      'me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
      dioTestClient: dio);

  test("should return given data from the server", () {
    expect(validTokenResponse.statusCode, 200);
    expect(validTokenResponse.body['id'], 'xE7jOejl9FI');
  });
}

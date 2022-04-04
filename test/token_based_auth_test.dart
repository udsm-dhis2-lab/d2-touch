import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
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
      tokenObject: sampleAuthToken);

  UserQuery userQuery = UserQuery(database: db);

  User? user = await userQuery.getOne();

  test('should get user information with authentication token', () async {
    expect(user, isNotNull);
    expect(user?.token, '6NK1ZJIWakbVaftAQnigzWgue98');
    expect(user?.tokenType, 'bearer');
  });
}

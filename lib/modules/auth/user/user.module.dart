import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModule {
  static createTables() async {
    return await UserQuery().createTable();
  }

  static Future<bool> isAuthenticated(
      {Future<SharedPreferences> sharedPreferenceInstance}) async {
    final databaseName = await UserModule.getDatabaseName(
        sharedPreferenceInstance: sharedPreferenceInstance);

    if (databaseName == null) {
      return false;
    }
    // TODO 2. Return not authenticated if database is present but user is not logged in
    return true;
  }

  static Future<String> getDatabaseName(
      {Future<SharedPreferences> sharedPreferenceInstance}) async {
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    return prefs.getString('databaseName');
  }

  static Future<bool> setDatabaseName(
      {@required String databaseName,
      Future<SharedPreferences> sharedPreferenceInstance}) async {
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    return prefs.setString('databaseName', databaseName);
  }

  static logOut() async {}

  UserQuery user = UserQuery();
}

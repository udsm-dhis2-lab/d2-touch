import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModule {
  static createTables() async {
    return await UserQuery().createTable();
  }

  static logOut() async {}

  UserQuery user = UserQuery();
}

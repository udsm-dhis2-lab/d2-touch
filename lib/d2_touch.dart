library dhis2_flutter_sdk;

import 'package:dhis2_flutter_sdk/modules/auth/user/user.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/data_set.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/organisation_unit.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/program.module.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'core/database/database_manager.dart';
import 'modules/auth/user/entities/user.entity.dart';
import 'modules/auth/user/models/login-response.model.dart';
import 'modules/auth/user/queries/user.query.dart';
import 'modules/metadata/dashboard/dashboard.module.dart';
import 'modules/metadata/data_element/data_element.module.dart';

class D2Touch {
  static Future<void> initialize(
      {String databaseName,
      bool inMemory,
      DatabaseFactory databaseFactory}) async {
    final newDatabaseName = databaseName ?? await UserModule.getDatabaseName();
    if (newDatabaseName != null) {
      DatabaseManager(
          databaseName: newDatabaseName,
          inMemory: inMemory,
          databaseFactory: databaseFactory);

      await DatabaseManager.instance.database;
      await UserModule.createTables();
      await OrganisationUnitModule.createTables();
      await DataElementModule.createTables();
      await DataSetModule.createTables();
      await ProgramModule.createTables();
      await DashboardModule.createTables();
    }
  }

  static Future<LoginResponseStatus> logIn(
      {@required String username,
      @required String password,
      @required String url,
      Future<SharedPreferences> sharedPreferenceInstance,
      bool inMemory,
      DatabaseFactory databaseFactory}) async {
    HttpResponse userReponse = await HttpClient.get('$url/api/me.json',
        username: username, password: password);

    if (userReponse.statusCode == 401) {
      return LoginResponseStatus.WRONG_CREDENTIALS;
    }

    final uri = Uri.parse(url).host;
    final String databaseName = '${username}_$uri';
    await UserModule.setDatabaseName(
        databaseName: databaseName,
        sharedPreferenceInstance:
            sharedPreferenceInstance ?? SharedPreferences.getInstance());

    await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    UserQuery userQuery = UserQuery();

    Map<String, dynamic> userData = userReponse.body;
    userData['password'] = password;
    userData['isLoggedIn'] = true;
    final user = User.fromJson(userData);
    await userQuery.setData(user).save();

    return LoginResponseStatus.ONLINE_LOGIN_SUCCESS;
  }

  static UserModule userModule = UserModule();

  static OrganisationUnitModule organisationUnitModule =
      OrganisationUnitModule();

  static DataElementModule dataElementModule = DataElementModule();

  static DataSetModule dataSetModule = DataSetModule();

  static ProgramModule programModule = ProgramModule();

  static DashboardModule dashboardModule = DashboardModule();
}

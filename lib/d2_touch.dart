library dhis2_flutter_sdk;

import 'package:dhis2_flutter_sdk/modules/auth/user/user.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/data_set.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/organisation_unit.module.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/program.module.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
      {String? databaseName,
      bool? inMemory,
      DatabaseFactory? databaseFactory}) async {
    final newDatabaseName = databaseName ?? await D2Touch.getDatabaseName();
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

  static Future<bool> isAuthenticated(
      {Future<SharedPreferences>? sharedPreferenceInstance,
      bool? inMemory,
      DatabaseFactory? databaseFactory}) async {
    WidgetsFlutterBinding.ensureInitialized();
    final databaseName = await D2Touch.getDatabaseName(
        sharedPreferenceInstance: sharedPreferenceInstance);

    if (databaseName == null) {
      return false;
    }

    await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    User? user = await D2Touch.userModule.user.getOne();
    return user!.isLoggedIn;
  }

  static Future<String?> getDatabaseName(
      {Future<SharedPreferences>? sharedPreferenceInstance}) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    return prefs.getString('databaseName');
  }

  static Future<bool> setDatabaseName(
      {required String databaseName,
      Future<SharedPreferences>? sharedPreferenceInstance}) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    return prefs.setString('databaseName', databaseName);
  }

  static Future<LoginResponseStatus> logIn(
      {required String username,
      required String password,
      required String url,
      Future<SharedPreferences>? sharedPreferenceInstance,
      bool? inMemory,
      DatabaseFactory? databaseFactory,
      Dio? dioTestClient}) async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpResponse userReponse = await HttpClient.get('me.json',
        baseUrl: url,
        username: username,
        password: password,
        dioTestClient: dioTestClient);

    if (userReponse.statusCode == 401) {
      return LoginResponseStatus.WRONG_CREDENTIALS;
    }

    final uri = Uri.parse(url).host;
    final String databaseName = '${username}_$uri';

    await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    await D2Touch.setDatabaseName(
        databaseName: databaseName,
        sharedPreferenceInstance:
            sharedPreferenceInstance ?? SharedPreferences.getInstance());

    UserQuery userQuery = UserQuery();

    Map<String, dynamic> userData = userReponse.body;
    userData['password'] = password;
    userData['isLoggedIn'] = true;
    userData['username'] = username;
    userData['baseUrl'] = url;
    final user = User.fromJson(userData);
    await userQuery.setData(user).save();

    return LoginResponseStatus.ONLINE_LOGIN_SUCCESS;
  }

  static Future<bool> logOut() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool logOutSuccess = false;
    try {
      User? currentUser = await D2Touch.userModule.user.getOne();

      Map<String, dynamic> userObject = currentUser!.toJson();
      userObject['isLoggedIn'] = false;
      final user = User.fromJson(userObject);

      await D2Touch.userModule.user.setData(user).save();
      logOutSuccess = true;
    } catch (e) {}
    return logOutSuccess;
  }

  static UserModule userModule = UserModule();

  static OrganisationUnitModule organisationUnitModule =
      OrganisationUnitModule();

  static DataElementModule dataElementModule = DataElementModule();

  static DataSetModule dataSetModule = DataSetModule();

  static ProgramModule programModule = ProgramModule();

  static DashboardModule dashboardModule = DashboardModule();
}

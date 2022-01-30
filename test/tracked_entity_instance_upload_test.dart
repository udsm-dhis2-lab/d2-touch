import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/tracked_entity_instance.query.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/tracked_entity_instances.sample.dart';
import 'tracked_entity_instance_upload_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  UserQuery userQuery = UserQuery(database: db);
  await userQuery.setData(user).save();

  final TrackedEntityInstance trackedEntityInstance =
      TrackedEntityInstance.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][0],
    'dirty': false
  });

  await TrackedEntityInstanceQuery().setData(trackedEntityInstance).save();

  TrackedEntityInstance? savedTrackedEntityInstance =
      await TrackedEntityInstanceQuery()
          .byId('x2kJgpb0XQC')
          .withAttributes()
          .withEnrollments()
          .getOne();

  print(savedTrackedEntityInstance?.toJson());
}

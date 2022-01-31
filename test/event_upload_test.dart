import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/enrollment.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/tracked_entity_instance.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/tracked_entity_instances.sample.dart';
import '../sample/enrollment_import_summary.sample.dart';
import '../sample/enrollment_upload.sample.dart';
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

  final Enrollment enrollment = Enrollment.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][0]['enrollments']
        [0],
    'dirty': true
  });

  await EnrollmentQuery().setData(enrollment).save();

  final Enrollment secondEnrollment = Enrollment.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][1]['enrollments']
        [0],
    'dirty': true
  });

  await EnrollmentQuery().setData(secondEnrollment).save();

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onPost('https://play.dhis2.org/2.35.11/api/enrollments',
      (server) => server.reply(409, sampleEnrollmentImportSummary),
      data: sampleEnrollmentUpload);

  List<Enrollment>? enrollmentUpload =
      await EnrollmentQuery().upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfull import', () {
    final successImports = (enrollmentUpload ?? [])
        .where((enrollment) => enrollment.synced == true)
        .toList();
    expect(successImports.length, 1);
  });

  test(
      'should not set sync status to true for unsuccessfull import and save import summary',
      () {
    final unSuccessfulImports = (enrollmentUpload ?? [])
        .where((enrollment) => enrollment.syncFailed == false)
        .toList();

    expect(unSuccessfulImports.length, 1);
    expect(unSuccessfulImports[0].lastSyncSummary != null, true);
  });
}

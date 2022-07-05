import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/user/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/user/queries/user.query.dart';
import 'package:d2_touch/modules/file_resource/entities/file_resource.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/file_resource.sample.dart';
import 'file_resource_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  UserQuery userQuery = UserQuery(database: db);

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.14';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();

  final List<FileResource> fileResources = sampleFileResources
      .map((fileResource) => FileResource.fromJson(fileResource))
      .toList();

  await D2Touch.fileResourceModule.fileResource.setData(fileResources).save();

  final List<FileResource> savedFileResources =
      await D2Touch.fileResourceModule.fileResource.get();

  test(
      'should save provided file resources information into the phone database',
      () {
    expect(savedFileResources.length, 1);
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  var formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(savedFileResources[0].localFilePath)
  });

  dioAdapter.onPost('https://play.dhis2.org/2.35.14/api/fileResources',
      (server) => server.reply(202, fileResourceUploadResponse),
      data: formData);

  List<FileResource>? fileResourceUpload = await D2Touch
      .fileResourceModule.fileResource
      .upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfull import', () {
    final successImports = (fileResourceUpload ?? [])
        .where((event) => event.synced == true)
        .toList();
    expect(successImports.length, 1);
  });
}

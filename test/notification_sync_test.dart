import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:dhis2_flutter_sdk/modules/notification/entities/message_conversation.entity.dart';
import 'package:dhis2_flutter_sdk/modules/notification/queries/message_conversation.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dataset_sync_test.reflectable.dart';
import '../sample/current_user.sample.dart';
import '../sample/data_sets.sample.dart';
import '../sample/message_conversation.sample.dart';

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
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();
  final notificationQuery = MessageConversationQuery(database: db);

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/messageConversations.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,status,subject,messageType,lastMessage,read&paging=false',
    (server) => server.reply(200, sampleMessageConversations),
  );

  await notificationQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<MessageConversation> messageConversations =
      await notificationQuery.get();

  test('should store all incoming  notification', () {
    expect(messageConversations.length, 26);
  });
}

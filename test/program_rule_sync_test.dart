import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_action.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/program_rule.sample.dart';
import 'program_rule_sync_test.reflectable.dart';

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

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programRules.json?filter=program.id:in:[IpHINAT79UW]&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,condition,description,program,programRuleActions[id,dirty,lastUpdated,created,name,displayName,shortName,code,content,data,displayContent,programRuleActionType,evaluationTime,description,dataElement,trackedEntityAttribute,programRule]&paging=false',
    (server) => server.reply(200, sampleProgramRules),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();
  final programRuleQuery = ProgramRuleQuery(database: db);

  await programRuleQuery
      .whereIn(attribute: 'program', values: ['IpHINAT79UW'], merge: false)
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<ProgramRule> programRules = await ProgramRuleQuery().withActions().get();

  List<ProgramRuleAction> programRuleActions =
      await ProgramRuleActionQuery().get();

  test('should download and store all incoming program rule metadata', () {
    expect(programRules.length, 4);
    expect(programRuleActions.length, 4);
  });
}

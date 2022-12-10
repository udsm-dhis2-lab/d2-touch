import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/event.sample.dart';
import '../sample/event_import_summary.sample.dart';
import '../sample/event_upload.sample.dart';
import '../sample/program.sample.dart';
import '../sample/program_stage.sample.dart';
import '../sample/tracked_entity_instances.sample.dart';
import 'event_sync_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: 'flutter_test',
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/events.json?fields=event,eventDate,dueDate,program,programStage,orgUnit,trackedEntityInstance,enrollment,enrollmentStatus,status,attributeCategoryOptions,lastUpdated,created,followup,deleted,attributeOptionCombo,dataValues[dataElement,value,lastUpdated,created,storedBy,providedElseWhere]&orgUnit=DiszpKrYNg8&program=IpHINAT79UW&programStage=ZzYYXq4fJie&order=eventDate:desc&pageSize=100&page=1',
    (server) => server.reply(200, sampleEvents),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule2.user.setData(user).save();

  List<Program> programs = List.from((samplePrograms['programs'] ?? []))
      .map<Program>((program) => Program.fromJson(program))
      .toList();

  await d2.programModule.program.setData(programs).save();

  List<ProgramStage> programStages = List.from(
          (sampleProgramStages['programStages'] ?? []))
      .map<ProgramStage>((programStage) => ProgramStage.fromJson(programStage))
      .toList();

  await d2.programModule.programStage.setData(programStages).save();

  await d2.trackerModule.event
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .byProgramStage('ZzYYXq4fJie')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<Event> events = await d2.trackerModule.event.get();
  test('should store all incoming events', () {
    expect(events.length, 75);
  });

  final Event event = Event.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][0]['enrollments']
        [0]['events'][0],
    'dirty': true
  });

  await d2.trackerModule.event.setData(event).save();

  final Event secondEvent = Event.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][2]['enrollments']
        [0]['events'][0],
    'dirty': true
  });

  await d2.trackerModule.event.setData(secondEvent).save();

  dioAdapter.onPost('https://play.dhis2.org/2.35.11/api/events',
      (server) => server.reply(409, sampleEventImportSummary),
      data: sampleEventUpload);

  List<Event>? eventUpload =
      await d2.trackerModule.event.upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfull import', () {
    final successImports =
        (eventUpload ?? []).where((event) => event.synced == true).toList();
    expect(successImports.length, 1);
  });

  test(
      'should not set sync status to true for unsuccessfull import and save import summary',
      () {
    final unSuccessfulImports = (eventUpload ?? [])
        .where((event) => event.syncFailed == false)
        .toList();

    expect(unSuccessfulImports.length, 1);
    expect(unSuccessfulImports[0].lastSyncSummary != null, true);
  });
}

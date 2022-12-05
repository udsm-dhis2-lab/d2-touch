import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/user/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/user/queries/user.query.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section_attribute.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element_option.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_variable.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_section.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_section_attribute.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_data_element.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_data_element_option.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_section.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/program.sample.dart';
import 'program_sync_test.reflectable.dart';

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
    'https://play.dhis2.org/2.35.11/api/programs.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariables[id,name,displayName,created,lastUpdated,programRuleVariableSourceType,useCodeForOptionSet,program,dataElement,trackedEntityAttribute,progamStage],programTrackedEntityAttributes[id,name,displayName,attributeValues,mandatory,renderOptionsAsRadio,sortOrder,valueType,trackedEntityAttribute[id,code,name,displayName,formName,shortName,aggregationType,unique,generated,optionSetValue,optionSet[id,name,options[code,name,id]]]],programSections[id,name,created,lastUpdated,displayName,renderType,displayFormName,sortOrder,trackedEntityAttributes[id~rename(attribute)]],programStages[id,name,created,lastUpdated,formType,generatedByEnrollmentDate,displayFormName,sortOrder,hideDueDate,enableUserAssignment,minDaysFromStart,executionDateLabel,preGenerateUID,displayName,description,displayExecutionDateLabel,openAfterEnrollment,repeatable,featureType,remindCompleted,displayGenerateEventBox,validationStrategy,autoGenerateEvent,blockEntryForm,programStageSections[id,name,displayName,displayFormName,created,lastUpdated,renderType,sortOrder,dataElements[id~rename(dataElement)]],programStageDataElements[id,created,lastUpdated,displayInReports,skipSynchronization,renderOptionsAsRadio,allowFutureDate,compulsory,allowProvidedElseWhere,sortOrder,dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]]&paging=false',
    (server) => server.reply(200, samplePrograms),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await userQuery.setData(user).save();
  final programQuery = ProgramQuery(database: db);
  await programQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<Program> programs = await programQuery.get();

  List<ProgramTrackedEntityAttribute> programTrackedEntityAttributes =
      await D2Touch.programModule.programTrackedEntityAttribute
          .withOptions()
          .get();

  programTrackedEntityAttributes.forEach((attribute) {
    print(attribute.translation);
  });

  test('should store all incoming program metadata', () {
    expect(programs.length, 14);
    expect(programTrackedEntityAttributes.length, 4);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programs.json?filter=id:in:[IpHINAT79UX]&fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariables[id,name,displayName,created,lastUpdated,programRuleVariableSourceType,useCodeForOptionSet,program,dataElement,trackedEntityAttribute,progamStage],programTrackedEntityAttributes[id,name,displayName,attributeValues,mandatory,renderOptionsAsRadio,sortOrder,valueType,trackedEntityAttribute[id,code,name,displayName,formName,shortName,aggregationType,unique,generated,optionSetValue,optionSet[id,name,options[code,name,id]]]],programSections[id,name,created,lastUpdated,displayName,renderType,displayFormName,sortOrder,trackedEntityAttributes[id~rename(attribute)]],programStages[id,name,created,lastUpdated,formType,generatedByEnrollmentDate,displayFormName,sortOrder,hideDueDate,enableUserAssignment,minDaysFromStart,executionDateLabel,preGenerateUID,displayName,description,displayExecutionDateLabel,openAfterEnrollment,repeatable,featureType,remindCompleted,displayGenerateEventBox,validationStrategy,autoGenerateEvent,blockEntryForm,programStageSections[id,name,displayName,displayFormName,created,lastUpdated,renderType,sortOrder,dataElements[id~rename(dataElement)]],programStageDataElements[id,created,lastUpdated,displayInReports,skipSynchronization,renderOptionsAsRadio,allowFutureDate,compulsory,allowProvidedElseWhere,sortOrder,dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]]&paging=false',
    (server) => server.reply(200, sampleFilteredPrograms),
  );

  await programQuery.byIds(['IpHINAT79UX']).download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  Program? filteredProgram = await programQuery.byId('IpHINAT79UX').getOne();

  test('should store all incoming filtered program metadata', () {
    expect(filteredProgram?.id, 'IpHINAT79UX');
  });

  List<ProgramStage> programStages =
      await ProgramStageQuery().withDataElements().get();

  List<ProgramStageDataElement> programStageElements =
      await ProgramStageDataElementQuery().get();

  List<ProgramStageDataElementOption> programStageElementOptions =
      await ProgramStageDataElementOptionQuery().get();

  List<ProgramRuleVariable> programRuleVariables =
      await ProgramRuleVariableQuery().get();

  List<ProgramSection> programSections =
      await ProgramSectionQuery().withAttributes().get();

  List<ProgramSectionAttribute> programSectionAttributes =
      await ProgramSectionAttributeQuery().get();

  List<ProgramStageSection> programStageSections =
      await ProgramStageSectionQuery().withDataElements().get();

  test(
      'should store all program stages, their elements and options per selected program',
      () {
    expect(programStages.length, 2);
    expect(programStageElements.length, 22);
    expect(programStageElementOptions.length, 48);
    expect(programRuleVariables.length, 4);
    expect(programSections.length, 1);
    expect(programSectionAttributes.length, 3);
    expect(programStageSections.length, 1);
    expect(programStageSections[0].dataElements?.length, 1);
  });
}

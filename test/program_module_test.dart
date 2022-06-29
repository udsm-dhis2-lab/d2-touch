import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'program_module_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  sqfliteFfiInit();

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  ProgramQuery programQuery = D2Touch.programModule.program;
  ProgramStageQuery programStageQuery = D2Touch.programModule.programStage;

  final program = Program(
    id: 'test1',
    name: "Test 1",
    shortName: 'Test 1',
    dirty: false,
    captureCoordinates: true,
    completeEventsExpiryDays: 15,
    displayIncidentDate: false,
    enrollmentDateLabel: '',
    featureType: '',
    ignoreOverdueEvents: true,
    incidentDateLabel: '',
    onlyEnrollOnce: false,
    organisationUnits: '',
    programRuleVariables: [],
    programType: 'EVENT',
    selectEnrollmentDatesInFuture: true,
    selectIncidentDatesInFuture: false,
    trackedEntity: '',
    trackedEntityType: '',
    useFirstStageDuringRegistration: true,
    withoutRegistration: true,
  );

  var insertResult = await programQuery.setData(program).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await programQuery.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.programType, 'EVENT');
    expect(result.captureCoordinates, true);
  });

  final programStage = ProgramStage(
      id: 'programstage1',
      name: 'Program Stage 1',
      shortName: 'Program Stage 1',
      featureType: '',
      captureCoordinates: false,
      sortOrder: 1,
      allowGenerateNextVisit: true,
      autoGenerateEvent: true,
      blockEntryForm: true,
      dueDateLabel: 'Due Date',
      executionDateLabel: 'Execution Date',
      formType: 'DEFAULT',
      generatedByEnrollmentDate: false,
      hideDueDate: false,
      minDaysFromStart: 3,
      program: {"id": "test1"},
      programStageDataElements: [],
      programStageSections: [],
      repeatable: false,
      dirty: false);

  var insertProgramStageResult =
      await programStageQuery.setData(programStage).save();

  test('should return success if program stage is inserted into the database',
      () {
    expect(insertProgramStageResult, 1);
  });

  var programStageResult =
      await programStageQuery.byId('programstage1').withProgram().getOne();

  test('should return saved program stage details', () {
    expect(programStageResult.id, 'programstage1');
    expect(programStageResult.name, 'Program Stage 1');
    expect(programStageResult.shortName, 'Program Stage 1');
  });

  // var programWithStages =
  //     await programQuery.byId('test1').withProgramStages().getOne();

  test('should return program with stage information', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.programType, 'EVENT');
    expect(result.captureCoordinates, true);
  });
}

import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/event.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/queries/attribute_reserved_value.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../sample/current_user.sample.dart';
import '../sample/program.sample.dart';
import '../sample/reserved_values.sample.dart';
import 'generate_event_test.reflectable.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
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

  List<Program> programs = [];
  samplePrograms['programs'].forEach((program) {
    programs.add(Program.fromJson({...program, 'dirty': false}));
  });

  await ProgramQuery().setData(programs).save();

  List<AttributeReservedValue> attributeResrvedValues = [];
  sampleReservedValues.forEach((reservedValue) {
    attributeResrvedValues.add(
        AttributeReservedValue.fromJson({...reservedValue, 'dirty': false}));
  });

  await AttributeReservedValueQuery().setData(attributeResrvedValues).save();

  await D2Touch.trackerModule.attributeReservedValue.get();

  final TrackedEntityInstance trackedEntityInstance = await D2Touch
      .trackerModule.trackedEntityInstance
      .byProgram('IpHINAT79UW')
      .byOrgUnit('fnei293faf')
      .create();

  final TrackedEntityInstance createdInstance = await D2Touch
      .trackerModule.trackedEntityInstance
      .byId(trackedEntityInstance.id as String)
      .getOne();

  final Event event = await D2Touch.trackerModule.event
      .byProgramStage('A03MvHHogjR')
      .byOrgUnit('fnei293faf')
      .byEnrollment(trackedEntityInstance.enrollments?[0].enrollment as String)
      .create();

  final Event? createdEvent =
      await D2Touch.trackerModule.event.byId(event.id as String).getOne();

  test('should return created tracked entity instance with generated values',
      () {
    expect(createdInstance.id, trackedEntityInstance.id);
    expect(createdInstance.orgUnit, 'fnei293faf');
    expect(
        (trackedEntityInstance.attributes ?? [])
            .lastWhere((attribute) => attribute.attribute == 'lZGmxYbs97q')
            .attribute,
        'lZGmxYbs97q');
    expect(createdEvent?.id, event.id);
  });
}

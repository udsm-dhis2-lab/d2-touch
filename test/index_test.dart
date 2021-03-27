import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

import 'index_test.reflectable.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  const MethodChannel sqflite = MethodChannel('com.tekartik.sqflite');
  sqflite.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  initializeReflectable();
  final organisationUnit = await OrganisationUnitQuery().get();

  print(organisationUnit);
  test('adds one to input values', () {
    expect(organisationUnit, isA<OrganisationUnitQuery>());
  });
}

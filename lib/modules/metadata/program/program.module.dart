import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';

class ProgramModule {
  static createTables() async {
    return await ProgramQuery().createTable();
  }

  ProgramQuery program = ProgramQuery();
}

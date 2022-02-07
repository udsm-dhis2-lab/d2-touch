import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageDataElementQuery extends BaseQuery<ProgramStageDataElement> {
  ProgramStageDataElementQuery({Database? database})
      : super(database: database);
}

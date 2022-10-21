import 'package:d2_touch/modules/metadata/program/entities/program_section_attribute.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqlite_api.dart';

class ProgramSectionAttributeQuery extends BaseQuery<ProgramSectionAttribute> {
  ProgramSectionAttributeQuery({Database? database})
      : super(database: database);
}

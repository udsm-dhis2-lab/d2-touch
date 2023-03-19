import 'package:d2_touch/modules/metadata/program/entities/program_relationship.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramRelationshipQuery extends BaseQuery<ProgramRelationship> {
  ProgramRelationshipQuery({Database? database}) : super(database: database);
}
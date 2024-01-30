import 'package:d2_touch/modules/metadata/program/entities/program_relationship.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramRelationshipQuery extends BaseQuery<ProgramRelationship> {
  String? toProgram;
  String? fromProgram;

  ProgramRelationshipQuery({Database? database}) : super(database: database);

  ProgramRelationshipQuery byToProgram(String toProgram) {
    this.toProgram = toProgram;
    return this.where(attribute: 'toProgram', value: toProgram);
  }

  ProgramRelationshipQuery byFromProgram(String fromProgram) {
    this.fromProgram = fromProgram;
    return this.where(attribute: 'fromProgram', value: fromProgram);
  }

  @override
  Future<String> dhisUrl({List<String>? fields}) {
    if (this.fromProgram != null) {
      return Future.value(
          'relationshipTypes.json?fields=${(fields ?? []).isNotEmpty ? (fields ?? []).join(',') : 'id,name,toConstraint[program[id,code,name]],fromConstraint[program[id,name,code]]'}&filter=fromConstraint.program.id:eq:${fromProgram}&paging=false');
    } else {
      return Future.value(
          'relationshipTypes.json?fields=id,name,toConstraint[program[id,code,name]],fromConstraint[program[id,name,code]]&filter=toConstraint.program.id:eq:${toProgram}&paging=false');
    }
  }
}

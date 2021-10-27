import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageQuery extends BaseQuery<ProgramStage> {
  ProgramStageQuery({Database database}) : super(database: database);

  ProgramStageQuery withProgram() {
    final program = Repository<Program>();
    final Column relationColumn = this.repository.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == program.entity?.tableName);

    this.relations.add(relationColumn.relation);
    return this;
  }
}

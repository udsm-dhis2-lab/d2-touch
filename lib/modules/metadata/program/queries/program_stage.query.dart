import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageQuery extends BaseQuery<ProgramStage> {
  ProgramStageQuery({Database? database}) : super(database: database);

  ProgramStageQuery withProgram() {
    final program = Repository<Program>();
    final Column relationColumn = this.repository.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName ==
        program.entity.tableName);

    this.relations.add(relationColumn.relation as ColumnRelation);
    return this;
  }

  ProgramStageQuery withDataElements() {
    final dataElement = Repository<ProgramStageDataElement>();
    final Column? relationColumn = dataElement.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'programStageDataElements',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramStageDataElement)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStageDataElement)
                  as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }
}

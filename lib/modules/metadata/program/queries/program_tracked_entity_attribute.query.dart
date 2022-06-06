import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/attribute_option.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramTrackedEntityAttributeQuery
    extends BaseQuery<ProgramTrackedEntityAttribute> {
  ProgramTrackedEntityAttributeQuery({Database? database})
      : super(database: database);

  ProgramTrackedEntityAttributeQuery withOptions() {
    final attributeOption = Repository<AttributeOption>();

    final Column? relationColumn = attributeOption.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'options',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(AttributeOption)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(AttributeOption) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:reflectable/mirrors.dart';
import 'package:sqflite/sqflite.dart';

class TrackedEntityInstanceQuery extends BaseQuery<TrackedEntityInstance> {
  String? orgUnit;
  String? program;
  TrackedEntityInstanceQuery({Database? database}) : super(database: database);

  TrackedEntityInstanceQuery withAttributes() {
    final attributeValue = Repository<TrackedEntityAttributeValue>();

    final Column? relationColumn = attributeValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'attributes',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery withEnrollments() {
    final enrollment = Repository<Enrollment>();
    final Column? relationColumn = enrollment.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'enrollments',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this;
  }

  TrackedEntityInstanceQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  String get dhisUrl {
    return 'trackedEntityInstances.json?ou=${this.orgUnit}&program=${this.program}&programStatus=ACTIVE&pageSize=50&order=lastUpdated:desc&fields=*';
  }
}

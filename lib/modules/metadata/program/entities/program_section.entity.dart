import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section_attribute.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'programsection', apiResourceName: 'programSections')
class ProgramSection extends IdentifiableEntity {
  @Column(nullable: true)
  String? formName;

  @Column(nullable: true)
  String? description;

  @Column()
  int sortOrder;

  @Column(nullable: true)
  String? renderType;

  @ManyToOne(joinColumnName: 'program', table: Program)
  dynamic program;

  @OneToMany(table: ProgramSectionAttribute)
  List<ProgramSectionAttribute>? attributes;

  ProgramSection(
      {required String id,
      required bool dirty,
      required String created,
      required String lastUpdated,
      required String name,
      required String displayName,
      this.description,
      required this.sortOrder,
      this.formName,
      this.renderType,
      required this.program,
      this.attributes})
      : super(
          id: id,
          dirty: dirty,
          created: created,
          lastUpdated: lastUpdated,
          name: name,
          displayName: displayName,
        );

  factory ProgramSection.fromJson(Map<String, dynamic> jsonData) {
    final renderType = jsonData['renderType'] is String
        ? jsonData['renderType']
        : jsonData['renderType']?['MOBILE']?['type'];

    return ProgramSection(
        id: jsonData['id'],
        dirty: jsonData['dirty'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated'],
        name: jsonData['name'],
        displayName: jsonData['displayName'],
        formName: jsonData['formName'] ?? jsonData['displayFormName'],
        renderType: renderType,
        description: jsonData['description'],
        sortOrder: jsonData['sortOrder'],
        program: jsonData['program'],
        attributes: List<dynamic>.from(jsonData['attributes'] ??
                jsonData['trackedEntityAttributes'] ??
                [])
            .map((attribute) => ProgramSectionAttribute.fromJson({
                  ...attribute,
                  'programSection': jsonData['id'],
                  'dirty': false
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['formName'] = this.formName;
    data['renderType'] = this.renderType;
    data['sortOrder'] = this.sortOrder;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['program'] = this.program;
    data['dirty'] = this.dirty;
    data['attributes'] = this.attributes;
    return data;
  }
}

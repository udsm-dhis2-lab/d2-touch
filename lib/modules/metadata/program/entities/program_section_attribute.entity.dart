import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programsectionattribute',
    apiResourceName: 'programSectionAttributes')
class ProgramSectionAttribute extends BaseEntity {
  @Column()
  String attribute;

  @ManyToOne(joinColumnName: 'programSection', table: ProgramSection)
  dynamic programSection;

  ProgramSectionAttribute(
      {required String id,
      required bool dirty,
      String? created,
      String? lastUpdated,
      required this.attribute,
      required this.programSection})
      : super(id: id, dirty: dirty, created: created, lastUpdated: lastUpdated);

  factory ProgramSectionAttribute.fromJson(Map<String, dynamic> jsonData) {
    return ProgramSectionAttribute(
        id: '${jsonData['programSection']}_${jsonData['attribute']}',
        dirty: jsonData['dirty'],
        attribute: jsonData['attribute'],
        programSection: jsonData['programSection'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['attribute'] = this.attribute;
    data['programSection'] = this.programSection;
    data['dirty'] = this.dirty;
    return data;
  }
}

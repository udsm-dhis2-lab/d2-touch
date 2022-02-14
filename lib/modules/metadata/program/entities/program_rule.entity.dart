import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'programrule', apiResourceName: 'programRules')
class ProgramRule extends BaseEntity {
  @Column()
  String condition;

  @Column(nullable: true)
  String? description;

  @ManyToOne(table: Program, joinColumnName: 'program')
  dynamic program;

  ProgramRule(
      {String? id,
      String? name,
      this.description,
      required this.condition,
      this.program,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory ProgramRule.fromJson(Map<String, dynamic> json) {
    return ProgramRule(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        condition: json['condition'],
        program: json['program'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['condition'] = this.condition;
    data['program'] = this.program;
    data['dirty'] = this.dirty;
    return data;
  }
}

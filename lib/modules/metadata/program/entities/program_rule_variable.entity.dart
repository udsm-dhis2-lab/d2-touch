import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programrulevariable', apiResourceName: 'programRuleVariables')
class ProgramRuleVariable extends BaseEntity {
  @Column()
  String programRuleVariableSourceType;

  @Column(nullable: true)
  String? useCodeForOptionSet;

  @ManyToOne(table: Program, joinColumnName: 'program')
  dynamic program;

  @Column(nullable: true)
  String? dataElement;

  @Column(nullable: true)
  String? trackedEntityAttribute;

  @OneToMany(table: ProgramRuleAction)
  List<ProgramRuleAction>? programRuleActions;

  ProgramRuleVariable(
      {String? id,
      String? name,
      String? displayName,
      required this.programRuleVariableSourceType,
      this.program,
      this.useCodeForOptionSet,
      this.programRuleActions,
      this.dataElement,
      this.trackedEntityAttribute,
      required bool dirty})
      : super(id: id, name: name, displayName: displayName, dirty: dirty);

  factory ProgramRuleVariable.fromJson(Map<String, dynamic> json) {
    return ProgramRuleVariable(
        id: json['id'],
        name: json['name'],
        programRuleVariableSourceType: json['programRuleVariableSourceType'],
        useCodeForOptionSet: json['useCodeForOptionSet'],
        dataElement: json['dataElement'],
        trackedEntityAttribute: json['trackedEntityAttribute'],
        program: json['program'],
        programRuleActions: List<dynamic>.from(json['programRuleActions'] ?? [])
            .map((programRuleAction) => ProgramRuleAction.fromJson({
                  ...programRuleAction,
                  'programRule': json['id'],
                  'dirty': false
                }))
            .toList(),
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['useCodeForOptionSet'] = this.useCodeForOptionSet;
    data['dataElement'] = this.dataElement;
    data['trackedEntityAttribute'] = this.trackedEntityAttribute;
    data['programRuleVariableSourceType'] = this.programRuleVariableSourceType;
    data['program'] = this.program;
    data['programRuleActions'] = this.programRuleActions;
    data['dirty'] = this.dirty;
    return data;
  }
}

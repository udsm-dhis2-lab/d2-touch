import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/attribute_option.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programtrackedentityattribute',
    apiResourceName: 'programTrackedEntityAttributes')
class ProgramTrackedEntityAttribute extends BaseEntity {
  @Column()
  String attribute;

  @Column(nullable: true)
  String? formName;

  @Column(nullable: true)
  bool? renderOptionsAsRadio;

  @Column()
  int sortOrder;

  @Column()
  String valueType;

  @Column()
  bool mandatory;

  @Column(nullable: true)
  String? aggregationType;

  @Column(nullable: true)
  bool? generated;

  @Column(nullable: true)
  bool? isUnique;

  @Column(nullable: true)
  bool? optionSetValue;

  @Column(nullable: true)
  int? optionSetValueCount;

  @Column(nullable: true)
  String? optionSetName;

  @ManyToOne(joinColumnName: 'program', table: Program)
  dynamic program;

  @OneToMany(table: AttributeOption)
  List<AttributeOption>? options;

  ProgramTrackedEntityAttribute(
      {required String id,
      required this.attribute,
      required String name,
      required this.sortOrder,
      required this.valueType,
      required this.mandatory,
      this.formName,
      String? displayName,
      this.renderOptionsAsRadio,
      this.aggregationType,
      this.generated,
      this.program,
      this.isUnique,
      this.optionSetValue,
      this.optionSetValueCount,
      this.optionSetName,
      this.options,
      required bool dirty})
      : super(id: id, name: name, displayName: displayName, dirty: dirty);

  factory ProgramTrackedEntityAttribute.fromJson(
      Map<String, dynamic> jsonData) {
    final optionSetValueCount =
        jsonData['trackedEntityAttribute']?['optionSet']?['options']?.length;
    return ProgramTrackedEntityAttribute(
        id: jsonData['id'],
        attribute:
            jsonData['attribute'] ?? jsonData['trackedEntityAttribute']?['id'],
        renderOptionsAsRadio: jsonData['renderOptionsAsRadio'],
        name: jsonData['trackedEntityAttribute']?['name'] ?? jsonData['name'],
        displayName: jsonData['trackedEntityAttribute']?['displayName'] ??
            jsonData['displayName'],
        formName: jsonData['trackedEntityAttribute']?['formName'] ??
            jsonData['formName'],
        program: jsonData['program'],
        valueType: jsonData['valueType'],
        sortOrder: jsonData['sortOrder'],
        mandatory: jsonData['mandatory'],
        aggregationType: jsonData['aggregationType'] ??
            jsonData['trackedEntityAttribute']?['aggregationType'],
        generated: jsonData['generated'] ??
            jsonData['trackedEntityAttribute']?['generated'],
        isUnique: jsonData['isUnique'] ??
            jsonData['trackedEntityAttribute']?['unique'],
        optionSetValue: jsonData['optionSetValue'] ??
            jsonData['trackedEntityAttribute']?['optionSetValue'],
        optionSetValueCount: optionSetValueCount,
        optionSetName: jsonData['optionSetName'] ??
            jsonData['trackedEntityAttribute']?['optionSet']?['name'],
        options: List<dynamic>.from(jsonData['options'] ??
                jsonData['trackedEntityAttribute']?['optionSet']?['options'] ??
                [])
            .map((option) => AttributeOption.fromJson({
                  ...option,
                  'id': '${option['id']}_${jsonData['id']}}',
                  'programTrackedEntityAttribute': jsonData['id'],
                  'dirty': false
                }))
            .toList(),
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['program'] = this.program;
    data['displayName'] = this.displayName;
    data['formName'] = this.formName;
    data['sortOrder'] = this.sortOrder;
    data['valueType'] = this.valueType;
    data['attribute'] = this.attribute;
    data['renderOptionsAsRadio'] = this.renderOptionsAsRadio;
    data['mandatory'] = this.mandatory;
    data['aggregationType'] = this.aggregationType;
    data['generated'] = this.generated;
    data['isUnique'] = this.isUnique;
    data['optionSetValue'] = this.optionSetValue;
    data['optionSetName'] = this.optionSetName;
    data['options'] = this.options;
    data['optionSetValueCount'] = this.optionSetValueCount;
    return data;
  }
}

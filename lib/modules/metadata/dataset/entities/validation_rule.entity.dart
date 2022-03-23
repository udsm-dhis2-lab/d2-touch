import 'dart:convert';

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'data_set.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'validationrule', apiResourceName: 'validationRules')
class ValidationRule extends BaseEntity {
  @Column()
  String? description;

  @Column(nullable: true)
  String? displayFormName;

  @Column()
  String? instruction;

  @Column()
  String? displayInstruction;

  @Column()
  String operator;

  @Column(nullable: true)
  int? periodOffset;

  @Column()
  String periodType;

  @Column()
  String rightSide;

  @Column()
  String leftSide;

  @ManyToOne(table: DataSet, joinColumnName: 'dataSet')
  dynamic dataSet;

  ValidationRule(
      {String? id,
      String? created,
      String? lastUpdated,
      required String name,
      String? displayName,
      this.description,
      this.displayFormName,
      required this.operator,
      this.instruction,
      this.displayInstruction,
      this.periodOffset,
      this.dataSet,
      required this.periodType,
      required this.leftSide,
      required this.rightSide,
      required bool dirty})
      : super(
            id: id,
            name: name,
            displayName: displayName,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory ValidationRule.fromJson(Map<String, dynamic> json) {
    const JsonEncoder encoder = JsonEncoder();

    final dynamic leftSide = encoder.convert(json['leftSide']);
    final dynamic rightSide = encoder.convert(json['rightSide']);

    return ValidationRule(
        id: json['id'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        name: json['name'],
        displayName: json['displayName'],
        displayFormName: json['displayFormName'],
        description: json['description'],
        instruction: json['instruction'],
        displayInstruction: json['displayInstruction'],
        operator: json['operator'],
        periodOffset: json['periodOffset'],
        periodType: json['periodType'],
        leftSide: leftSide,
        rightSide: rightSide,
        dataSet: json['dataSet'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['displayFormName'] = this.displayFormName;
    data['description'] = this.description;
    data['instruction'] = this.instruction;
    data['displayInstruction'] = this.displayInstruction;
    data['operator'] = this.operator;
    data['periodType'] = this.periodType;
    data['leftSide'] = this.leftSide;
    data['rightSide'] = this.rightSide;
    data['dataSet'] = this.dataSet;
    data['dirty'] = this.dirty;

    return data;
  }
}

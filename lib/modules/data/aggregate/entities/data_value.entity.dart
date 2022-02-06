import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'data_value_set.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'datavalue', apiResourceName: 'dataValues')
class DataValue extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String dataElement;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? attributeOptionCombo;

  @Column(type: ColumnType.TEXT)
  String categoryOptionCombo;

  @Column(type: ColumnType.TEXT)
  String value;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? synced;

  @ManyToOne(joinColumnName: 'dataValueSet', table: DataValueSet)
  dynamic dataValueSet;

  // @Column("simple-json") categoryCombo: any;
  // @Column("simple-json") dataSetElements: any;
  // @Column("simple-json") organisationUnits: any;

  DataValue(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required this.dataElement,
      required this.attributeOptionCombo,
      required this.categoryOptionCombo,
      required this.dataValueSet,
      required this.value,
      required this.synced,
      required dirty})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory DataValue.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ??
        '${json['dataElement']}_${json['categoryOptionCombo']}_${json['orgUnit']}_${json['period']}';
    return DataValue(
        id: id,
        name: json['name'] ?? id,
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        dataElement: json['dataElement'],
        attributeOptionCombo: json['attributeOptionCombo'],
        categoryOptionCombo: json['categoryOptionCombo'],
        dataValueSet: json['dataValueSet'],
        value: json['value'],
        synced: json['synced']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['dataElement'] = this.dataElement;
    data['attributeOptionCombo'] = this.attributeOptionCombo;
    data['categoryOptionCombo'] = this.categoryOptionCombo;
    data['dataValueSet'] = this.dataValueSet;
    data['value'] = this.value;
    data['synced'] = this.synced;

    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'datavalueset', apiResourceName: 'dataValueSets')
class DataValueSet extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String period;

  @Column(type: ColumnType.TEXT)
  String orgUnit;

  @Column(type: ColumnType.BOOLEAN)
  bool synced;

  @Column(type: ColumnType.TEXT)
  String dataSet;

  @OneToMany(table: DataValue)
  List<DataValue>? dataValues;

  DataValueSet(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required this.period,
      required this.orgUnit,
      required this.synced,
      this.dataValues,
      required this.dataSet,
      required dirty})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory DataValueSet.fromJson(Map<String, dynamic> json) {
    return DataValueSet(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        synced: json['synced'],
        period: json['period'],
        orgUnit: json['orgUnit'],
        dataSet: json['dataSet'],
        dataValues: json['dataValues']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['synced'] = this.synced;
    data['period'] = this.period;
    data['orgUnit'] = this.orgUnit;
    data['dataSet'] = this.dataSet;
    data['dataValues'] = this.dataValues;

    return data;
  }
}

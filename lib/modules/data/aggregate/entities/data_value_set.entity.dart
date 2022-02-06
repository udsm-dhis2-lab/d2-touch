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

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @Column(type: ColumnType.TEXT)
  String dataSet;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? attributeOptionCombo;

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
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
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
    final id =
        json['id'] ?? '${json['dataSet']}_${json['orgUnit']}_${json['period']}';

    return DataValueSet(
        id: id,
        name: json['name'] ?? id,
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: json['lastSyncSummary'],
        lastSyncDate: json['lastSyncDate'],
        period: json['period'],
        orgUnit: json['orgUnit'],
        dataSet: json['dataSet'],
        dataValues: List<dynamic>.from(json['dataValues'] ?? [])
            .map((dataValue) => DataValue.fromJson(
                {...dataValue, 'dirty': false, 'dataValueSet': id}))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['period'] = this.period;
    data['orgUnit'] = this.orgUnit;
    data['dataSet'] = this.dataSet;
    data['dataValues'] = this.dataValues;

    return data;
  }

  static toUpload() {
    return {
      "dataSet": "dataSetID",
      "completeDate": "date",
      "period": "period",
      "orgUnit": "orgUnitID",
      "attributeOptionCombo": "aocID",
      "dataValues": [
        {
          "dataElement": "dataElementID",
          "categoryOptionCombo": "cocID",
          "value": "1",
          "comment": "comment1"
        },
        {
          "dataElement": "dataElementID",
          "categoryOptionCombo": "cocID",
          "value": "2",
          "comment": "comment2"
        },
        {
          "dataElement": "dataElementID",
          "categoryOptionCombo": "cocID",
          "value": "3",
          "comment": "comment3"
        }
      ]
    };
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'dataset', apiResourceName: 'dataSets')
class DataSet extends BaseEntity {
  @Column(type: ColumnType.INTEGER)
  int timelyDays;

  @Column(type: ColumnType.TEXT)
  String formType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? description;

  @Column(type: ColumnType.TEXT)
  String periodType;

  @Column(type: ColumnType.INTEGER)
  int openFuturePeriods;

  @Column(type: ColumnType.INTEGER)
  int expiryDays;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? renderHorizontally;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? renderAsTabs;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? fieldCombinationRequired;

  // @Column("simple-json") categoryCombo: any;
  // @Column("simple-json") dataSetElements: any;
  // @Column("simple-json") organisationUnits: any;

  DataSet(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required String shortName,
      String? code,
      String? displayName,
      required this.timelyDays,
      required this.formType,
      required this.periodType,
      required this.openFuturePeriods,
      required this.expiryDays,
      this.renderHorizontally,
      this.renderAsTabs,
      this.description,
      this.fieldCombinationRequired,
      required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory DataSet.fromJson(Map<String, dynamic> json) {
    return DataSet(
      id: json['id'],
      name: json['name'],
      created: json['created'],
      shortName: json['shortName'],
      code: json['code'],
      displayName: json['displayName'],
      timelyDays: json['timelyDays'],
      formType: json['formType'],
      description: json['description'],
      dirty: json['dirty'],
      expiryDays: json['expiryDays'],
      openFuturePeriods: json['openFuturePeriods'],
      periodType: json['periodType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    data['timelyDays'] = this.timelyDays;
    data['formType'] = this.formType;
    data['description'] = this.description;
    data['expiryDays'] = this.expiryDays;
    data['periodType'] = this.periodType;
    data['openFuturePeriods'] = this.openFuturePeriods;
    data['dirty'] = this.dirty;

    return data;
  }
}

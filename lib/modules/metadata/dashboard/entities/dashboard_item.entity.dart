import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/dashboard/entities/dashboard.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'dashboarditem')
class DashboardItem extends BaseEntity {
  @Column(type: ColumnType.TEXT, name: 'type', nullable: true)
  String type;

  @Column(type: ColumnType.INTEGER, name: 'contentcount', nullable: true)
  int contentcount;

  @Column(type: ColumnType.INTEGER, name: 'interpretationcount', nullable: true)
  int interpretationcount;

  @Column(
      type: ColumnType.INTEGER, name: 'interpretationlikecount', nullable: true)
  int interpretationlikecount;

  @Column(type: ColumnType.TEXT, name: 'chart', nullable: true)
  String chart;

  @Column(type: ColumnType.TEXT, name: 'report', nullable: true)
  String report;

  @ManyToOne(joinColumnName: 'dashboard')
  Dashboard dashboard;

  DashboardItem(
      {@required String id,
      String created,
      String lastUpdated,
      @required this.dashboard,
      this.type,
      this.contentcount,
      this.interpretationcount,
      this.interpretationlikecount,
      this.chart,
      this.report,
      @required dirty});

  factory DashboardItem.fromJson(Map<String, dynamic> json) {
    return DashboardItem(
        id: json['id'],
        type: json['type'],
        dashboard: json['dashboard'],
        created: json['created'],
        contentcount: json['contentcount'],
        interpretationcount: json['interpretationcount'],
        interpretationlikecount: json['interpretationlikecount'],
        chart: json['chart'],
        report: json['report'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['type'] = this.type;
    data['dashboard'] = this.dashboard.toJson();
    data['contentcount'] = this.contentcount;
    data['interpretationcount'] = this.interpretationcount;
    data['interpretationlikecount'] = this.interpretationlikecount;
    data['chart'] = this.chart;
    data['report'] = this.report;
    data['dirty'] = this.dirty;

    return data;
  }
}

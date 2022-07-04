import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'attributeReserveValue',
    apiResourceName: 'attributeReserveValues')
class TrackedEntityInstanceFileResource extends BaseEntity {
  @Column(nullable: true)
  String localReference;
  @Column()
  String serverReference;
  @Column()
  String trackedEntityAttribute;
  @Column()
  String trackedEntityInstance;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  TrackedEntityInstanceFileResource(
      {required String id,
      required String name,
      required this.localReference,
      required this.serverReference,
      required this.trackedEntityAttribute,
      required this.trackedEntityInstance,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      String? created,
      String? lastUpdated,
      required bool dirty})
      : super(
            id: id,
            name: name,
            dirty: dirty,
            created: created,
            lastUpdated: lastUpdated) {
    this.id = this.id ??
        '${this.trackedEntityInstance}_${this.trackedEntityAttribute}';
    this.name = this.name ?? this.id;
  }

  factory TrackedEntityInstanceFileResource.fromJson(
      Map<String, dynamic> json) {
    const JsonEncoder encoder = JsonEncoder();
    final dynamic lastSyncSummary = encoder.convert(json['lastSyncSummary']);
    return TrackedEntityInstanceFileResource(
        id: json['id'],
        name: json['name'],
        localReference: json['localReference'],
        serverReference: json['serverReference'],
        trackedEntityAttribute: json['trackedEntityAttribute'],
        trackedEntityInstance: json['trackedEntityInstance'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['localReference'] = this.localReference;
    data['serverReference'] = this.serverReference;
    data['trackedEntityAttribute'] = this.trackedEntityAttribute;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['dirty'] = this.dirty;
    return data;
  }
}

import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'enrollment.entity.dart';
import 'event.entity.dart';
import 'tracked_entity_attribute_value.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'trackedEntityInstance',
    apiResourceName: 'trackedEntityInstances')
class TrackedEntityInstance extends IdentifiableEntity {
  @Column()
  String orgUnit;

  @Column()
  String trackedEntityType;

  @Column()
  late String? trackedEntityInstance;

  @Column(nullable: true)
  bool? deleted;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? inactive;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  bool? transfer;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @OneToMany(table: TrackedEntityAttributeValue)
  List<TrackedEntityAttributeValue>? attributes;

  @OneToMany(table: Enrollment)
  List<Enrollment>? enrollments;

  TrackedEntityInstance(
      {String? id,
      String? name,
      String? created,
      String? lastUpdated,
      required this.orgUnit,
      required bool dirty,
      required this.trackedEntityType,
      this.trackedEntityInstance,
      this.deleted,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.inactive,
      this.enrollments,
      this.attributes,
      this.transfer})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.trackedEntityInstance = this.trackedEntityInstance ?? this.id;
  }

  transferOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    this.transfer = true;
  }

  factory TrackedEntityInstance.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];

    const JsonEncoder encoder = JsonEncoder();
    final dynamic lastSyncSummary = encoder.convert(json['lastSyncSummary']);

    return TrackedEntityInstance(
        id: json['id'] ?? json['trackedEntityInstance'],
        name: json['trackedEntityInstance'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        orgUnit: json['orgUnit'],
        trackedEntityInstance: json['trackedEntityInstance'],
        trackedEntityType: json['trackedEntityType'],
        deleted: json['deleted'],
        synced: json['synced'],
        transfer: json['transfer'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        inactive: json['inactive'],
        enrollments: json['enrollments'] != null
            ? List<dynamic>.from(json['enrollments'])
                .map((enrollment) => Enrollment.fromJson({
                      ...enrollment,
                      'dirty': enrollment['dirty'] ?? json['dirty'] ?? false,
                      'synced': json['synced']
                    }))
                .toList()
            : null,
        attributes: List<Map<String, dynamic>>.from(attributes ?? [])
            .map((attribute) => TrackedEntityAttributeValue.fromJson({
                  ...attribute,
                  'id': attribute['id'] ??
                      '${json['trackedEntityInstance']}_${attribute['attribute']}',
                  'trackedEntityInstance': json['trackedEntityInstance'],
                  'dirty': attribute['dirty'] ?? false
                }))
            .toList(),
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name ?? this.id;
    data['orgUnit'] = this.orgUnit;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['trackedEntityType'] = this.trackedEntityType;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['inactive'] = this.inactive;
    data['enrollments'] = this.enrollments;
    data['attributes'] = this.attributes;
    data['dirty'] = this.dirty;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['transfer'] = this.transfer;
    return data;
  }

  static toUpload(
      TrackedEntityInstance trackedEntityInstance, List<Event>? events) {
    return {
      "trackedEntityType": trackedEntityInstance.trackedEntityType,
      "orgUnit": trackedEntityInstance.orgUnit,
      "trackedEntityInstance": trackedEntityInstance.trackedEntityInstance,
      "attributes": (trackedEntityInstance.attributes ?? [])
          .map((attribute) => TrackedEntityAttributeValue.toUpload(attribute))
          .toList(),
      "enrollments": (trackedEntityInstance.enrollments ?? [])
          .map((enrollment) => Enrollment.toUpload(enrollment, events))
          .toList()
    };
  }
}

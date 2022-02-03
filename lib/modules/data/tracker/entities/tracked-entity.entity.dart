import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'enrollment.entity.dart';
import 'tracked_entity_attribute_value.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'trackedEntityInstance',
    apiResourceName: 'trackedEntityInstances')
class TrackedEntityInstance extends BaseEntity {
  @Column()
  String orgUnit;

  @Column()
  String trackedEntityType;

  @Column()
  String trackedEntityInstance;

  @Column(nullable: true)
  bool? deleted;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? inactive;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @OneToMany(table: TrackedEntityAttributeValue)
  List<TrackedEntityAttributeValue>? attributes;

  @OneToMany(table: Enrollment)
  List<Enrollment>? enrollments;

  TrackedEntityInstance(
      {required String id,
      String? name,
      required this.orgUnit,
      required bool dirty,
      required this.trackedEntityType,
      required this.trackedEntityInstance,
      this.deleted,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.inactive,
      this.enrollments,
      this.attributes})
      : super(id: id, name: name, dirty: dirty);

  factory TrackedEntityInstance.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return TrackedEntityInstance(
        id: json['id'] ?? json['trackedEntityInstance'],
        name: json['trackedEntityInstance'],
        orgUnit: json['orgUnit'],
        trackedEntityInstance: json['trackedEntityInstance'],
        trackedEntityType: json['trackedEntityType'],
        deleted: json['deleted'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: json['lastSyncSummary'],
        lastSyncDate: json['lastSyncDate'],
        inactive: json['inactive'],
        enrollments: json['enrollments'] != null
            ? List<dynamic>.from(json['enrollments'])
                .map((enrollment) =>
                    Enrollment.fromJson({...enrollment, 'dirty': false}))
                .toList()
            : null,
        attributes: attributes != null
            ? List<Map<String, dynamic>>.from(attributes)
                .map((attribute) => TrackedEntityAttributeValue.fromJson({
                      ...attribute,
                      'id': attribute['id'] ??
                          '${json['trackedEntityInstance']}_${attribute['attribute']}',
                      'trackedEntityInstance': json['trackedEntityInstance'],
                      'dirty': attribute['dirty'] ?? false
                    }))
                .toList()
            : null,
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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
    return data;
  }

  static toUpload(TrackedEntityInstance trackedEntityInstance) {
    return {
      "trackedEntityType": trackedEntityInstance.trackedEntityType,
      "orgUnit": trackedEntityInstance.orgUnit,
      "trackedEntityInstance": trackedEntityInstance.trackedEntityInstance,
      "attributes": (trackedEntityInstance.attributes ?? [])
          .map((attribute) => TrackedEntityAttributeValue.toUpload(attribute))
          .toList(),
      "enrollments": (trackedEntityInstance.enrollments ?? [])
          .map((enrollment) => Enrollment.toUpload(enrollment))
          .toList()
    };
  }
}

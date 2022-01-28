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
  @Column()
  bool? deleted;
  @Column()
  bool? synced;
  @Column()
  bool? inactive;

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
      this.inactive,
      this.enrollments,
      this.attributes})
      : super(id: id, name: name, dirty: dirty);

  factory TrackedEntityInstance.fromJson(Map<String, dynamic> json) {
    return TrackedEntityInstance(
        id: json['id'] ?? json['trackedEntityInstance'],
        orgUnit: json['orgUnit'],
        trackedEntityInstance: json['trackedEntityInstance'],
        trackedEntityType: json['trackedEntityType'],
        deleted: json['deleted'],
        synced: json['synced'],
        inactive: json['inactive'],
        enrollments: json['enrollments'] != null
            ? List<dynamic>.from(json['enrollments'])
                .map((enrollment) => Enrollment.fromJson(enrollment))
                .toList()
            : null,
        attributes: json['attributes'] != null
            ? List<Map<String, dynamic>>.from(json['attributes'])
                .map((attribute) =>
                    TrackedEntityAttributeValue.fromJson(attribute))
                .toList()
            : null,
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orgUnit'] = this.orgUnit;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['trackedEntityType'] = this.trackedEntityType;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
    data['inactive'] = this.inactive;
    data['enrollments'] = this.enrollments;
    data['attributes'] = this.attributes;
    data['dirty'] = this.dirty;
    return data;
  }
}

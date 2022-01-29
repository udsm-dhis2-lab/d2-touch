import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'event.entity.dart';
import 'tracked-entity.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'enrollment', apiResourceName: 'enrollments')
class Enrollment extends BaseEntity {
  @Column()
  String enrollment;
  @Column()
  String incidentDate;
  @Column()
  String enrollmentDate;
  @Column()
  String trackedEntityType;
  @Column()
  String orgUnit;
  @Column()
  String program;
  @Column()
  String? status;
  @Column()
  bool? synced;

  @OneToMany(table: Event)
  List<Event>? events;

  @ManyToOne(
      joinColumnName: 'trackedEntityInstance', table: TrackedEntityInstance)
  dynamic trackedEntityInstance;

  Enrollment(
      {required String id,
      required String name,
      required this.enrollment,
      required this.incidentDate,
      required this.enrollmentDate,
      required this.trackedEntityType,
      required this.orgUnit,
      required this.program,
      required bool dirty,
      this.status,
      this.synced,
      this.events,
      this.trackedEntityInstance})
      : super(id: id, name: name, dirty: dirty);

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
        id: json['enrollment'],
        enrollment: json['enrollment'],
        name: json['enrollment'],
        incidentDate: json['incidentDate'],
        enrollmentDate: json['enrollmentDate'],
        trackedEntityType: json['trackedEntityType'],
        orgUnit: json['orgUnit'],
        program: json['program'],
        status: json['status'],
        synced: json['synced'],
        events: json['events'] != null
            ? List<dynamic>.from(json['events'])
                .map((event) => Event.fromJson({...event, 'dirty': false}))
                .toList()
            : null,
        trackedEntityInstance: json['trackedEntityInstance'],
        dirty: json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['enrollment'] = this.enrollment;
    data['incidentDate'] = this.incidentDate;
    data['enrollmentDate'] = this.enrollmentDate;
    data['trackedEntityType'] = this.trackedEntityType;
    data['orgUnit'] = this.orgUnit;
    data['program'] = this.program;
    data['status'] = this.status;
    data['synced'] = this.synced;
    data['events'] = this.events;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['dirty'] = this.dirty;

    return data;
  }
}

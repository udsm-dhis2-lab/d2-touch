import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

import 'event.entity.dart';
import 'tracked-entity.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'enrollment', apiResourceName: 'enrollments')
class Enrollment extends BaseEntity {
  @Column()
  String? enrollment;

  @Column()
  String? incidentDate;

  @Column()
  String? enrollmentDate;

  @Column()
  String trackedEntityType;

  @Column()
  String orgUnit;

  @Column()
  String program;

  @Column(nullable: true)
  String? status;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @OneToMany(table: Event)
  List<Event>? events;

  @ManyToOne(
      joinColumnName: 'trackedEntityInstance', table: TrackedEntityInstance)
  dynamic trackedEntityInstance;

  Enrollment(
      {String? id,
      String? name,
      String? created,
      String? lastUpdated,
      this.enrollment,
      this.incidentDate,
      this.enrollmentDate,
      required this.trackedEntityType,
      required this.orgUnit,
      required this.program,
      required bool dirty,
      this.status,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.events,
      this.trackedEntityInstance})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.enrollment = this.enrollment ?? this.id;
    this.name = this.name ?? this.enrollment;
    this.incidentDate = this.incidentDate ?? this.created;
    this.enrollmentDate = this.enrollmentDate ?? this.created;
  }

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
        id: json['enrollment'],
        enrollment: json['enrollment'],
        name: json['enrollment'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        incidentDate: json['incidentDate'],
        enrollmentDate: json['enrollmentDate'],
        trackedEntityType: json['trackedEntityType'],
        orgUnit: json['orgUnit'],
        program: json['program'],
        status: json['status'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: json['lastSyncSummary'],
        lastSyncDate: json['lastSyncDate'],
        events: List<dynamic>.from(json['events'] ?? [])
            .map((event) => Event.fromJson({...event, 'dirty': false}))
            .toList(),
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
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['events'] = this.events ?? [];
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['dirty'] = this.dirty;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;

    return data;
  }

  static toUpload(Enrollment enrollment, List<Event>? events) {
    final filteredEvents =
        (events ?? []).where((event) => event.enrollment == enrollment.id);
    return {
      "enrollment": enrollment.enrollment,
      "trackedEntityInstance": enrollment.trackedEntityInstance,
      "orgUnit": enrollment.orgUnit,
      "program": enrollment.program,
      "enrollmentDate": enrollment.enrollmentDate,
      "incidentDate": enrollment.incidentDate,
      "events": (filteredEvents).map((event) => Event.toUpload(event)).toList()
    };
  }
}

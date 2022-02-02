import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'enrollment.entity.dart';
import 'event_data_value.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'event', apiResourceName: 'events')
class Event extends BaseEntity {
  @Column()
  String event;

  @Column()
  String orgUnit;

  @Column()
  String status;

  @Column(nullable: true)
  String? eventDate;

  @Column(nullable: true)
  String? dueDate;

  @Column(nullable: true)
  bool? deleted;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @Column(nullable: true)
  String? storedBy;

  @Column(nullable: true)
  String? coordinate;

  @Column(nullable: true)
  String? trackedEntityInstance;

  @Column(nullable: true)
  String? attributeCategoryOptions;

  @Column(nullable: true)
  String? attributeOptionCombo;

  @Column(nullable: true)
  String? notes;

  @Column(nullable: true)
  String? eventType;

  @ManyToOne(joinColumnName: 'programStage', table: ProgramStage)
  dynamic programStage;

  @ManyToOne(joinColumnName: 'enrollment', table: Enrollment)
  dynamic enrollment;

  @OneToMany(table: EventDataValue)
  List<EventDataValue>? dataValues;

  Event(
      {required String id,
      required String name,
      required this.event,
      required this.orgUnit,
      required this.status,
      required dirty,
      this.eventDate,
      this.dueDate,
      this.deleted,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.storedBy,
      this.coordinate,
      this.trackedEntityInstance,
      this.attributeCategoryOptions,
      this.attributeOptionCombo,
      this.notes,
      this.eventType,
      required this.programStage,
      this.enrollment,
      this.dataValues})
      : super(id: id, name: name, dirty: dirty);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['event'],
        name: json['event'],
        event: json['event'],
        orgUnit: json['orgUnit'],
        status: json['status'],
        eventDate: json['eventDate'],
        dueDate: json['dueDate'],
        deleted: json['deleted'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: json['lastSyncSummary'],
        lastSyncDate: json['lastSyncDate'],
        storedBy: json['storedBy'],
        coordinate: json['coordinate'],
        trackedEntityInstance: json['trackedEntityInstance'],
        attributeCategoryOptions: json['attributeCategoryOptions'],
        attributeOptionCombo: json['attributeOptionCombo'],
        notes: json['notes'].toString(),
        eventType: json['eventType'],
        programStage: json['programStage'],
        enrollment: json['enrollment'],
        dataValues: json['dataValues'] != null
            ? List<dynamic>.from(json['dataValues'])
                .map((event) => EventDataValue.fromJson({
                      ...event,
                      "id": '${json['event']}_${event['dataElement']}',
                      "event": json['event'],
                      "dirty": false
                    }))
                .toList()
            : null,
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['event'] = this.event;
    data['orgUnit'] = this.orgUnit;
    data['status'] = this.status;
    data['eventDate'] = this.eventDate;
    data['dueDate'] = this.dueDate;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['storedBy'] = this.storedBy;
    data['coordinate'] = this.coordinate;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['attributeCategoryOptions'] = this.attributeCategoryOptions;
    data['attributeOptionCombo'] = this.attributeOptionCombo;
    data['notes'] = this.notes;
    data['eventType'] = this.eventType;
    data['programStage'] = this.programStage;
    data['enrollment'] = this.enrollment;
    data['dataValues'] = this.dataValues;
    data['dirty'] = this.dirty;
    return data;
  }

  static toUpload(Event event) {
    return {
      "event": event.event,
      "program": event.programStage['program'],
      "programStage": event.programStage['id'],
      "trackedEntityInstance": event.trackedEntityInstance,
      "orgUnit": event.orgUnit,
      "eventDate": event.eventDate,
      "status": event.status,
      "storedBy": event.storedBy,
      "coordinate": event.coordinate,
      "dataValues": (event.dataValues ?? [])
          .map((event) => EventDataValue.toUpload(event))
          .toList()
    };
  }
}

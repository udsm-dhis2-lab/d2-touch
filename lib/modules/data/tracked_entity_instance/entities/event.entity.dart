import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/entities/event_data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'enrollment.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'event', apiResourceName: 'events')
class Event extends BaseEntity {
  @Column()
  String event;
  @Column()
  String orgUnit;
  @Column()
  String status;
  @Column()
  String? eventDate;
  @Column()
  String? dueDate;
  @Column()
  bool? deleted;
  @Column()
  bool? synced;
  @Column()
  String? storedBy;
  @Column()
  String? coordinate;
  @Column()
  String? trackedEntityInstance;
  @Column()
  String? attributeCategoryOptions;
  @Column()
  String? attributeOptionCombo;
  @Column()
  String? notes;
  @Column()
  String? eventType;

  @ManyToOne(joinColumnName: 'programStage', table: ProgramStage)
  dynamic programStage;

  @ManyToOne(joinColumnName: 'enrollment', table: Enrollment)
  dynamic enrollment;

  @OneToMany()
  List<EventDataValue>? dataValues;

  Event(
      {required String id,
      required this.event,
      required this.orgUnit,
      required this.status,
      required dirty,
      this.eventDate,
      this.dueDate,
      this.deleted,
      this.synced,
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
      : super(id: id, dirty: dirty);

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        event: json['event'],
        orgUnit: json['orgUnit'],
        status: json['status'],
        eventDate: json['eventDate'],
        dueDate: json['dueDate'],
        deleted: json['deleted'],
        synced: json['synced'],
        storedBy: json['storedBy'],
        coordinate: json['coordinate'],
        trackedEntityInstance: json['trackedEntityInstance'],
        attributeCategoryOptions: json['attributeCategoryOptions'],
        attributeOptionCombo: json['attributeOptionCombo'],
        notes: json['notes'],
        eventType: json['eventType'],
        programStage: json['programStage'],
        enrollment: json['enrollment'],
        dataValues: json['dataValues'] != null
            ? List<dynamic>.from(json['dataValues'])
                .map((event) => EventDataValue.fromJson(event))
                .toList()
            : null,
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event'] = this.event;
    data['orgUnit'] = this.orgUnit;
    data['status'] = this.status;
    data['eventDate'] = this.eventDate;
    data['dueDate'] = this.dueDate;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
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
}

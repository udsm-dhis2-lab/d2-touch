import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

/// Event Isar Collection
/// 
/// DHIS2 event for data capture in tracker and event programs
/// Optimized for mobile data entry workflows
@collection
class EventIsar extends IdentifiableIsarEntity {
  /// Event ID (usually same as dhis2Id)
  @Index()
  String? event;

  /// Event status (ACTIVE, COMPLETED, CANCELLED, etc.)
  @Index()
  late String status;

  /// Organisation unit where event occurred
  @Index()
  late String orgUnit;

  /// Program stage this event belongs to
  @Index()
  late String programStage;

  /// Event date (when it occurred)
  @Index()
  String? eventDate;

  /// Event date timestamp for efficient queries
  @Index()
  int? eventDateTimestamp;

  /// Due date for the event
  String? dueDate;

  /// Due date timestamp
  int? dueDateTimestamp;

  /// Tracked entity instance this event belongs to
  @Index()
  String? trackedEntityInstance;

  /// Enrollment this event belongs to
  @Index()
  String? enrollment;

  /// Whether event is deleted
  @Index()
  bool deleted = false;

  /// Whether sync failed
  bool syncFailed = false;

  /// Whether user marked as saved
  @Index()
  bool saved = false;

  /// Last sync date
  String? lastSyncDate;

  /// Last sync timestamp
  @Index()
  int? lastSyncTimestamp;

  /// User who stored the event
  String? storedBy;

  /// Coordinate (latitude,longitude)
  String? coordinate;

  /// Attribute category options
  String? attributeCategoryOptions;

  /// Attribute option combo
  String? attributeOptionCombo;

  /// Event notes
  String? notes;

  /// Event type
  String? eventType;

  /// Serialized data values JSON
  String? dataValuesJson;

  /// Serialized sync summary JSON
  String? lastSyncSummaryJson;

  EventIsar() : super();

  /// Get event date as DateTime
  DateTime? get eventDateTime {
    if (eventDate != null) {
      try {
        return DateTime.parse(eventDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set event date from DateTime
  set eventDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      eventDate = dateTime.toIso8601String().split('T')[0]; // Date only
      eventDateTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      eventDate = null;
      eventDateTimestamp = null;
    }
  }

  /// Get due date as DateTime
  DateTime? get dueDateDateTime {
    if (dueDate != null) {
      try {
        return DateTime.parse(dueDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set due date from DateTime
  set dueDateDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      dueDate = dateTime.toIso8601String().split('T')[0];
      dueDateTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      dueDate = null;
      dueDateTimestamp = null;
    }
  }

  /// Get data values from JSON
  List<Map<String, dynamic>> get dataValues {
    if (dataValuesJson == null || dataValuesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(dataValuesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set data values as JSON
  set dataValues(List<Map<String, dynamic>> values) {
    dataValuesJson = jsonEncode(values);
  }

  /// Get data value by data element
  String? getDataValue(String dataElementId) {
    for (final value in dataValues) {
      if (value['dataElement'] == dataElementId) {
        return value['value']?.toString();
      }
    }
    return null;
  }

  /// Set data value
  void setDataValue(String dataElementId, dynamic value) {
    final values = dataValues;
    bool found = false;
    
    for (int i = 0; i < values.length; i++) {
      if (values[i]['dataElement'] == dataElementId) {
        values[i]['value'] = value;
        found = true;
        break;
      }
    }
    
    if (!found) {
      values.add({
        'dataElement': dataElementId,
        'value': value,
        'event': dhis2Id,
      });
    }
    
    dataValues = values;
    markDirty();
  }

  /// Check if event is overdue
  bool get isOverdue {
    if (dueDateTimestamp == null || status == 'COMPLETED') return false;
    return DateTime.now().millisecondsSinceEpoch > dueDateTimestamp!;
  }

  /// Mark as completed
  void markCompleted() {
    status = 'COMPLETED';
    if (eventDate == null) {
      eventDateTime = DateTime.now();
    }
    markDirty();
  }

  /// Factory constructor from JSON (DHIS2 API)
  factory EventIsar.fromApi(Map<String, dynamic> json) {
    final event = EventIsar();
    
    event.dhis2Id = json['id'] ?? json['event'] ?? '';
    event.name = json['event'] ?? event.dhis2Id;
    event.event = json['event'];
    event.status = json['status'] ?? 'ACTIVE';
    event.orgUnit = json['orgUnit'] ?? '';
    event.programStage = json['programStage'] ?? '';
    
    event.eventDate = json['eventDate'];
    if (json['eventDate'] != null) {
      try {
        final date = DateTime.parse(json['eventDate']);
        event.eventDateTimestamp = date.millisecondsSinceEpoch;
      } catch (e) {}
    }
    
    event.dueDate = json['dueDate'];
    if (json['dueDate'] != null) {
      try {
        final date = DateTime.parse(json['dueDate']);
        event.dueDateTimestamp = date.millisecondsSinceEpoch;
      } catch (e) {}
    }
    
    event.trackedEntityInstance = json['trackedEntityInstance'];
    event.enrollment = json['enrollment'];
    event.deleted = json['deleted'] ?? false;
    event.saved = json['saved'] ?? false;
    event.syncFailed = json['syncFailed'] ?? false;
    event.storedBy = json['storedBy'];
    event.coordinate = json['coordinate'];
    event.attributeCategoryOptions = json['attributeCategoryOptions'];
    event.attributeOptionCombo = json['attributeOptionCombo'];
    event.notes = json['notes'];
    event.eventType = json['eventType'];
    
    // Handle timestamps
    if (json['created'] != null) {
      event.serverCreated = json['created'];
      try {
        event.createdAt = DateTime.parse(json['created']);
      } catch (e) {}
    }
    
    if (json['lastUpdated'] != null) {
      event.serverLastUpdated = json['lastUpdated'];
      try {
        event.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {}
    }
    
    // Handle data values
    if (json['dataValues'] != null) {
      event.dataValues = (json['dataValues'] as List).cast<Map<String, dynamic>>();
    }
    
    event.dirty = json['dirty'] ?? false;
    
    return event;
  }

  /// Factory constructor from JSON (local)
  factory EventIsar.fromJson(Map<String, dynamic> json) {
    final event = EventIsar();
    
    event.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    event.name = json['name'] ?? '';
    event.event = json['event'];
    event.status = json['status'] ?? 'ACTIVE';
    event.orgUnit = json['orgUnit'] ?? '';
    event.programStage = json['programStage'] ?? '';
    
    event.eventDate = json['eventDate'];
    event.eventDateTimestamp = json['eventDateTimestamp'];
    event.dueDate = json['dueDate'];
    event.dueDateTimestamp = json['dueDateTimestamp'];
    
    event.trackedEntityInstance = json['trackedEntityInstance'];
    event.enrollment = json['enrollment'];
    event.deleted = json['deleted'] ?? false;
    event.saved = json['saved'] ?? false;
    event.syncFailed = json['syncFailed'] ?? false;
    
    event.lastSyncDate = json['lastSyncDate'];
    event.lastSyncTimestamp = json['lastSyncTimestamp'];
    event.storedBy = json['storedBy'];
    event.coordinate = json['coordinate'];
    event.attributeCategoryOptions = json['attributeCategoryOptions'];
    event.attributeOptionCombo = json['attributeOptionCombo'];
    event.notes = json['notes'];
    event.eventType = json['eventType'];
    
    event.dataValuesJson = json['dataValuesJson'];
    event.lastSyncSummaryJson = json['lastSyncSummaryJson'];
    
    // Base properties
    event.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    event.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    event.dirty = json['dirty'] ?? false;
    event.synced = json['synced'] ?? false;
    
    return event;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'event': event,
      'status': status,
      'orgUnit': orgUnit,
      'programStage': programStage,
      'eventDate': eventDate,
      'eventDateTimestamp': eventDateTimestamp,
      'dueDate': dueDate,
      'dueDateTimestamp': dueDateTimestamp,
      'trackedEntityInstance': trackedEntityInstance,
      'enrollment': enrollment,
      'deleted': deleted,
      'saved': saved,
      'syncFailed': syncFailed,
      'lastSyncDate': lastSyncDate,
      'lastSyncTimestamp': lastSyncTimestamp,
      'storedBy': storedBy,
      'coordinate': coordinate,
      'attributeCategoryOptions': attributeCategoryOptions,
      'attributeOptionCombo': attributeOptionCombo,
      'notes': notes,
      'eventType': eventType,
      'dataValuesJson': dataValuesJson,
      'lastSyncSummaryJson': lastSyncSummaryJson,
      'createdTimestamp': createdTimestamp,
      'lastUpdatedTimestamp': lastUpdatedTimestamp,
      'dirty': dirty,
      'synced': synced,
    };
  }

  /// Convert to DHIS2 upload format
  Map<String, dynamic> toUpload() {
    return {
      'event': event,
      'programStage': programStage,
      'trackedEntityInstance': trackedEntityInstance,
      'orgUnit': orgUnit,
      'eventDate': eventDate,
      'occurredAt': eventDate,
      'status': status,
      'storedBy': storedBy,
      'coordinate': coordinate,
      'enrollment': enrollment,
      'attributeCategoryOptions': attributeCategoryOptions,
      'attributeOptionCombo': attributeOptionCombo,
      'notes': notes,
      'dataValues': dataValues.map((dv) => {
        'dataElement': dv['dataElement'],
        'value': dv['value'],
      }).toList(),
    };
  }

  @override
  String toString() {
    return 'EventIsar(dhis2Id: $dhis2Id, status: $status, orgUnit: $orgUnit, eventDate: $eventDate)';
  }
}

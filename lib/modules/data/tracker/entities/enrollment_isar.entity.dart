import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

/// Enrollment Isar Collection
/// 
/// DHIS2 enrollment for tracker programs
/// Represents the enrollment of a tracked entity instance in a program
@collection
class EnrollmentIsar extends IdentifiableIsarEntity {
  /// Enrollment ID (usually same as dhis2Id)
  @Index()
  String? enrollment;

  /// Tracked entity instance this enrollment belongs to
  @Index()
  String? trackedEntityInstance;

  /// Program this enrollment is for
  @Index()
  late String program;

  /// Organisation unit where enrollment occurred
  @Index()
  late String orgUnit;

  /// Enrollment date
  @Index()
  String? enrollmentDate;

  /// Enrollment date timestamp for efficient queries
  @Index()
  int? enrollmentDateTimestamp;

  /// Incident date (date when the tracked entity was first seen)
  @Index()
  String? incidentDate;

  /// Incident date timestamp
  int? incidentDateTimestamp;

  /// Enrollment status (ACTIVE, COMPLETED, CANCELLED)
  @Index()
  late String status;

  /// Whether enrollment is deleted
  @Index()
  bool deleted = false;

  /// Whether sync failed
  bool syncFailed = false;

  /// Last sync date
  String? lastSyncDate;

  /// Last sync timestamp
  @Index()
  int? lastSyncTimestamp;

  /// User who stored the enrollment
  String? storedBy;

  /// Coordinate (latitude,longitude)
  String? coordinate;

  /// Attribute category options
  String? attributeCategoryOptions;

  /// Attribute option combo
  String? attributeOptionCombo;

  /// Follow up flag
  bool followUp = false;

  /// Completed date
  String? completedDate;

  /// Completed by user
  String? completedBy;

  /// Notes or comments
  String? notes;

  /// Serialized events JSON
  String? eventsJson;

  /// Serialized attributes JSON
  String? attributesJson;

  /// Serialized relationships JSON
  String? relationshipsJson;

  /// Serialized sync summary JSON
  String? lastSyncSummaryJson;

  EnrollmentIsar() : super();

  /// Get enrollment date as DateTime
  DateTime? get enrollmentDateTime {
    if (enrollmentDate != null) {
      try {
        return DateTime.parse(enrollmentDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set enrollment date from DateTime
  set enrollmentDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      enrollmentDate = dateTime.toIso8601String().split('T')[0]; // Date only
      enrollmentDateTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      enrollmentDate = null;
      enrollmentDateTimestamp = null;
    }
  }

  /// Get incident date as DateTime
  DateTime? get incidentDateTime {
    if (incidentDate != null) {
      try {
        return DateTime.parse(incidentDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set incident date from DateTime
  set incidentDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      incidentDate = dateTime.toIso8601String().split('T')[0];
      incidentDateTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      incidentDate = null;
      incidentDateTimestamp = null;
    }
  }

  /// Get completed date as DateTime
  DateTime? get completedDateTime {
    if (completedDate != null) {
      try {
        return DateTime.parse(completedDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set completed date from DateTime
  set completedDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      completedDate = dateTime.toIso8601String().split('T')[0];
    } else {
      completedDate = null;
    }
  }

  /// Get events from JSON
  List<Map<String, dynamic>> get events {
    if (eventsJson == null || eventsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(eventsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set events as JSON
  set events(List<Map<String, dynamic>> eventList) {
    eventsJson = jsonEncode(eventList);
  }

  /// Get attributes from JSON
  List<Map<String, dynamic>> get attributes {
    if (attributesJson == null || attributesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(attributesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set attributes as JSON
  set attributes(List<Map<String, dynamic>> attrs) {
    attributesJson = jsonEncode(attrs);
  }

  /// Get relationships from JSON
  List<Map<String, dynamic>> get relationships {
    if (relationshipsJson == null || relationshipsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(relationshipsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set relationships as JSON
  set relationships(List<Map<String, dynamic>> rels) {
    relationshipsJson = jsonEncode(rels);
  }

  /// Get attribute value by ID
  String? getAttributeValue(String attributeId) {
    for (final attr in attributes) {
      if (attr['attribute'] == attributeId) {
        return attr['value']?.toString();
      }
    }
    return null;
  }

  /// Set attribute value
  void setAttributeValue(String attributeId, dynamic value) {
    final attrs = attributes;
    bool found = false;
    
    for (int i = 0; i < attrs.length; i++) {
      if (attrs[i]['attribute'] == attributeId) {
        attrs[i]['value'] = value;
        found = true;
        break;
      }
    }
    
    if (!found) {
      attrs.add({
        'attribute': attributeId,
        'value': value,
        'trackedEntityInstance': trackedEntityInstance,
      });
    }
    
    attributes = attrs;
    markDirty();
  }

  /// Check if enrollment is active
  bool get isActive => status == 'ACTIVE';

  /// Check if enrollment is completed
  bool get isCompleted => status == 'COMPLETED';

  /// Check if enrollment is cancelled
  bool get isCancelled => status == 'CANCELLED';

  /// Mark enrollment as completed
  void markCompleted({String? completedByUser}) {
    status = 'COMPLETED';
    completedDateTime = DateTime.now();
    completedBy = completedByUser;
    markDirty();
  }

  /// Mark enrollment as cancelled
  void markCancelled() {
    status = 'CANCELLED';
    markDirty();
  }

  /// Reactivate enrollment
  void reactivate() {
    status = 'ACTIVE';
    completedDate = null;
    completedBy = null;
    markDirty();
  }

  /// Get enrollment duration in days
  int? get durationInDays {
    if (enrollmentDateTime == null) return null;
    
    final endDate = isCompleted && completedDateTime != null 
        ? completedDateTime! 
        : DateTime.now();
    
    return endDate.difference(enrollmentDateTime!).inDays;
  }

  /// Factory constructor from JSON (DHIS2 API)
  factory EnrollmentIsar.fromApi(Map<String, dynamic> json) {
    final enrollment = EnrollmentIsar();
    
    enrollment.dhis2Id = json['enrollment'] ?? json['id'] ?? '';
    enrollment.name = json['enrollment'] ?? enrollment.dhis2Id;
    enrollment.enrollment = json['enrollment'];
    enrollment.trackedEntityInstance = json['trackedEntityInstance'];
    enrollment.program = json['program'] ?? '';
    enrollment.orgUnit = json['orgUnit'] ?? '';
    enrollment.status = json['status'] ?? 'ACTIVE';
    
    enrollment.enrollmentDate = json['enrollmentDate'];
    if (json['enrollmentDate'] != null) {
      try {
        final date = DateTime.parse(json['enrollmentDate']);
        enrollment.enrollmentDateTimestamp = date.millisecondsSinceEpoch;
      } catch (e) {}
    }
    
    enrollment.incidentDate = json['incidentDate'];
    if (json['incidentDate'] != null) {
      try {
        final date = DateTime.parse(json['incidentDate']);
        enrollment.incidentDateTimestamp = date.millisecondsSinceEpoch;
      } catch (e) {}
    }
    
    enrollment.deleted = json['deleted'] ?? false;
    enrollment.syncFailed = json['syncFailed'] ?? false;
    enrollment.storedBy = json['storedBy'];
    enrollment.coordinate = json['coordinate'];
    enrollment.attributeCategoryOptions = json['attributeCategoryOptions'];
    enrollment.attributeOptionCombo = json['attributeOptionCombo'];
    enrollment.followUp = json['followUp'] ?? false;
    enrollment.completedDate = json['completedDate'];
    enrollment.completedBy = json['completedBy'];
    enrollment.notes = json['notes'];
    
    // Handle timestamps
    if (json['created'] != null) {
      enrollment.serverCreated = json['created'];
      try {
        enrollment.createdAt = DateTime.parse(json['created']);
      } catch (e) {}
    }
    
    if (json['lastUpdated'] != null) {
      enrollment.serverLastUpdated = json['lastUpdated'];
      try {
        enrollment.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {}
    }
    
    // Handle collections
    if (json['events'] != null) {
      enrollment.events = (json['events'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['attributes'] != null) {
      enrollment.attributes = (json['attributes'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['relationships'] != null) {
      enrollment.relationships = (json['relationships'] as List).cast<Map<String, dynamic>>();
    }
    
    enrollment.dirty = json['dirty'] ?? false;
    
    return enrollment;
  }

  /// Factory constructor from JSON (local)
  factory EnrollmentIsar.fromJson(Map<String, dynamic> json) {
    final enrollment = EnrollmentIsar();
    
    enrollment.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    enrollment.name = json['name'] ?? '';
    enrollment.enrollment = json['enrollment'];
    enrollment.trackedEntityInstance = json['trackedEntityInstance'];
    enrollment.program = json['program'] ?? '';
    enrollment.orgUnit = json['orgUnit'] ?? '';
    enrollment.status = json['status'] ?? 'ACTIVE';
    
    enrollment.enrollmentDate = json['enrollmentDate'];
    enrollment.enrollmentDateTimestamp = json['enrollmentDateTimestamp'];
    enrollment.incidentDate = json['incidentDate'];
    enrollment.incidentDateTimestamp = json['incidentDateTimestamp'];
    
    enrollment.deleted = json['deleted'] ?? false;
    enrollment.syncFailed = json['syncFailed'] ?? false;
    enrollment.lastSyncDate = json['lastSyncDate'];
    enrollment.lastSyncTimestamp = json['lastSyncTimestamp'];
    enrollment.storedBy = json['storedBy'];
    enrollment.coordinate = json['coordinate'];
    enrollment.attributeCategoryOptions = json['attributeCategoryOptions'];
    enrollment.attributeOptionCombo = json['attributeOptionCombo'];
    enrollment.followUp = json['followUp'] ?? false;
    enrollment.completedDate = json['completedDate'];
    enrollment.completedBy = json['completedBy'];
    enrollment.notes = json['notes'];
    
    enrollment.eventsJson = json['eventsJson'];
    enrollment.attributesJson = json['attributesJson'];
    enrollment.relationshipsJson = json['relationshipsJson'];
    enrollment.lastSyncSummaryJson = json['lastSyncSummaryJson'];
    
    // Base properties
    enrollment.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    enrollment.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    enrollment.dirty = json['dirty'] ?? false;
    enrollment.synced = json['synced'] ?? false;
    
    return enrollment;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'enrollment': enrollment,
      'trackedEntityInstance': trackedEntityInstance,
      'program': program,
      'orgUnit': orgUnit,
      'enrollmentDate': enrollmentDate,
      'enrollmentDateTimestamp': enrollmentDateTimestamp,
      'incidentDate': incidentDate,
      'incidentDateTimestamp': incidentDateTimestamp,
      'status': status,
      'deleted': deleted,
      'syncFailed': syncFailed,
      'lastSyncDate': lastSyncDate,
      'lastSyncTimestamp': lastSyncTimestamp,
      'storedBy': storedBy,
      'coordinate': coordinate,
      'attributeCategoryOptions': attributeCategoryOptions,
      'attributeOptionCombo': attributeOptionCombo,
      'followUp': followUp,
      'completedDate': completedDate,
      'completedBy': completedBy,
      'notes': notes,
      'eventsJson': eventsJson,
      'attributesJson': attributesJson,
      'relationshipsJson': relationshipsJson,
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
      'enrollment': enrollment,
      'trackedEntityInstance': trackedEntityInstance,
      'program': program,
      'orgUnit': orgUnit,
      'enrollmentDate': enrollmentDate,
      'incidentDate': incidentDate,
      'status': status,
      'storedBy': storedBy,
      'coordinate': coordinate,
      'attributeCategoryOptions': attributeCategoryOptions,
      'attributeOptionCombo': attributeOptionCombo,
      'followUp': followUp,
      'completedDate': completedDate,
      'completedBy': completedBy,
      'notes': notes,
      'attributes': attributes.map((attr) => {
        'attribute': attr['attribute'],
        'value': attr['value'],
      }).toList(),
      'events': events,
    };
  }

  @override
  String toString() {
    return 'EnrollmentIsar(dhis2Id: $dhis2Id, program: $program, status: $status, enrollmentDate: $enrollmentDate)';
  }
}

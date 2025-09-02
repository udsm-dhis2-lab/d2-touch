import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

/// TrackedEntityInstance Isar Collection
/// 
/// Core DHIS2 tracker entity for mobile health data collection
/// Optimized for offline-first mobile applications
@collection
class TrackedEntityIsar extends IdentifiableIsarEntity {
  /// Organisation unit where this entity is registered
  @Index()
  late String orgUnit;

  /// Type of tracked entity (e.g., person, equipment)
  @Index()
  late String trackedEntityType;

  /// Tracked entity instance ID (usually same as dhis2Id)
  @Index()
  String? trackedEntityInstance;

  /// Whether this entity is deleted
  @Index()
  bool deleted = false;

  /// Whether this entity is inactive
  bool inactive = false;

  /// Whether sync failed for this entity
  bool syncFailed = false;

  /// Whether this entity is marked for transfer to another org unit
  bool transfer = false;

  /// Whether user has marked this entity as saved
  @Index()
  bool saved = false;

  /// Last sync date (ISO string)
  String? lastSyncDate;

  /// Last sync timestamp for efficient queries
  @Index()
  int? lastSyncTimestamp;

  /// Serialized sync summary JSON
  String? lastSyncSummaryJson;

  /// Serialized attributes JSON
  String? attributesJson;

  /// Serialized enrollments JSON  
  String? enrollmentsJson;

  /// Serialized relationships JSON
  String? relationshipsJson;

  TrackedEntityIsar() : super();

  /// Get last sync date as DateTime
  DateTime? get lastSyncDateTime {
    if (lastSyncDate != null) {
      try {
        return DateTime.parse(lastSyncDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set last sync date from DateTime
  set lastSyncDateTime(DateTime? dateTime) {
    if (dateTime != null) {
      lastSyncDate = dateTime.toIso8601String();
      lastSyncTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      lastSyncDate = null;
      lastSyncTimestamp = null;
    }
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

  /// Get enrollments from JSON
  List<Map<String, dynamic>> get enrollments {
    if (enrollmentsJson == null || enrollmentsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(enrollmentsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set enrollments as JSON
  set enrollments(List<Map<String, dynamic>> enrls) {
    enrollmentsJson = jsonEncode(enrls);
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

  /// Get sync summary from JSON
  Map<String, dynamic>? get lastSyncSummary {
    if (lastSyncSummaryJson == null || lastSyncSummaryJson!.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(lastSyncSummaryJson!) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Set sync summary as JSON
  set lastSyncSummary(Map<String, dynamic>? summary) {
    if (summary != null) {
      lastSyncSummaryJson = jsonEncode(summary);
    } else {
      lastSyncSummaryJson = null;
    }
  }

  /// Transfer to another organisation unit
  void transferOrgUnit(String newOrgUnit) {
    orgUnit = newOrgUnit;
    transfer = true;
    markDirty();
  }

  /// Mark as saved by user
  void markSaved() {
    saved = true;
    markDirty();
  }

  /// Mark sync as successful
  void markSyncSuccess() {
    syncFailed = false;
    lastSyncDateTime = DateTime.now();
    markSynced();
  }

  /// Mark sync as failed
  void markSyncFailed([Map<String, dynamic>? summary]) {
    syncFailed = true;
    if (summary != null) {
      lastSyncSummary = summary;
    }
    lastSyncDateTime = DateTime.now();
    markDirty();
  }

  /// Get attribute value by attribute ID
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
        'trackedEntityInstance': dhis2Id,
      });
    }
    
    attributes = attrs;
    markDirty();
  }

  /// Check if enrolled in program
  bool isEnrolledInProgram(String programId) {
    return enrollments.any((enrollment) => 
      enrollment['program'] == programId && 
      enrollment['status'] != 'CANCELLED'
    );
  }

  /// Get active enrollment for program
  Map<String, dynamic>? getActiveEnrollment(String programId) {
    for (final enrollment in enrollments) {
      if (enrollment['program'] == programId && 
          enrollment['status'] == 'ACTIVE') {
        return enrollment;
      }
    }
    return null;
  }

  /// Factory constructor from JSON (DHIS2 API response)
  factory TrackedEntityIsar.fromApi(Map<String, dynamic> json) {
    final tei = TrackedEntityIsar();
    
    tei.dhis2Id = json['id'] ?? json['trackedEntityInstance'] ?? '';
    tei.name = json['trackedEntityInstance'] ?? tei.dhis2Id;
    tei.orgUnit = json['orgUnit'] ?? '';
    tei.trackedEntityType = json['trackedEntityType'] ?? '';
    tei.trackedEntityInstance = json['trackedEntityInstance'];
    
    tei.deleted = json['deleted'] ?? false;
    tei.inactive = json['inactive'] ?? false;
    tei.synced = json['synced'] ?? true;
    tei.saved = json['saved'] ?? false;
    tei.transfer = json['transfer'] ?? false;
    tei.syncFailed = json['syncFailed'] ?? false;
    
    // Handle timestamps
    if (json['created'] != null) {
      tei.serverCreated = json['created'];
      try {
        tei.createdAt = DateTime.parse(json['created']);
      } catch (e) {
        // Keep default timestamp
      }
    }
    
    if (json['lastUpdated'] != null) {
      tei.serverLastUpdated = json['lastUpdated'];
      try {
        tei.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {
        // Keep default timestamp
      }
    }
    
    if (json['lastSyncDate'] != null) {
      tei.lastSyncDateTime = DateTime.parse(json['lastSyncDate']);
    }
    
    // Handle complex objects
    if (json['attributes'] != null) {
      tei.attributes = (json['attributes'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['enrollments'] != null) {
      tei.enrollments = (json['enrollments'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['relationships'] != null) {
      tei.relationships = (json['relationships'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['lastSyncSummary'] != null) {
      tei.lastSyncSummary = json['lastSyncSummary'] as Map<String, dynamic>;
    }
    
    tei.dirty = json['dirty'] ?? false;
    
    return tei;
  }

  /// Factory constructor from JSON (local storage)
  factory TrackedEntityIsar.fromJson(Map<String, dynamic> json) {
    final tei = TrackedEntityIsar();
    
    tei.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    tei.name = json['name'] ?? '';
    tei.orgUnit = json['orgUnit'] ?? '';
    tei.trackedEntityType = json['trackedEntityType'] ?? '';
    tei.trackedEntityInstance = json['trackedEntityInstance'];
    
    tei.deleted = json['deleted'] ?? false;
    tei.inactive = json['inactive'] ?? false;
    tei.saved = json['saved'] ?? false;
    tei.transfer = json['transfer'] ?? false;
    tei.syncFailed = json['syncFailed'] ?? false;
    
    tei.lastSyncDate = json['lastSyncDate'];
    tei.lastSyncTimestamp = json['lastSyncTimestamp'];
    
    // JSON strings
    tei.attributesJson = json['attributesJson'];
    tei.enrollmentsJson = json['enrollmentsJson'];
    tei.relationshipsJson = json['relationshipsJson'];
    tei.lastSyncSummaryJson = json['lastSyncSummaryJson'];
    
    // Base properties
    tei.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    tei.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    tei.dirty = json['dirty'] ?? false;
    tei.synced = json['synced'] ?? false;
    tei.serverCreated = json['serverCreated'];
    tei.serverLastUpdated = json['serverLastUpdated'];
    
    return tei;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'orgUnit': orgUnit,
      'trackedEntityType': trackedEntityType,
      'trackedEntityInstance': trackedEntityInstance,
      'deleted': deleted,
      'inactive': inactive,
      'saved': saved,
      'transfer': transfer,
      'syncFailed': syncFailed,
      'lastSyncDate': lastSyncDate,
      'lastSyncTimestamp': lastSyncTimestamp,
      'attributesJson': attributesJson,
      'enrollmentsJson': enrollmentsJson,
      'relationshipsJson': relationshipsJson,
      'lastSyncSummaryJson': lastSyncSummaryJson,
      'createdTimestamp': createdTimestamp,
      'lastUpdatedTimestamp': lastUpdatedTimestamp,
      'dirty': dirty,
      'synced': synced,
      'serverCreated': serverCreated,
      'serverLastUpdated': serverLastUpdated,
    };
  }

  /// Convert to DHIS2 upload format
  Map<String, dynamic> toUpload() {
    return {
      'trackedEntityType': trackedEntityType,
      'orgUnit': orgUnit,
      'trackedEntityInstance': trackedEntityInstance,
      'attributes': attributes.map((attr) => {
        'attribute': attr['attribute'],
        'value': attr['value'],
      }).toList(),
      'enrollments': enrollments,
      'relationships': relationships.map((rel) => {
        'relationshipType': rel['relationshipType'],
        'from': rel['from'],
        'to': rel['to'],
      }).toList(),
    };
  }

  @override
  String toString() {
    return 'TrackedEntityIsar(dhis2Id: $dhis2Id, orgUnit: $orgUnit, type: $trackedEntityType, saved: $saved)';
  }
}

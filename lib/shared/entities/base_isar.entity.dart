import 'package:isar/isar.dart';

/// Base Isar Entity
/// 
/// Replaces the SQLite-based BaseEntity with Isar entity
/// All DHIS2 entities should extend this base entity
/// Provides common fields like id, dirty status, and timestamps
abstract class BaseIsarEntity {
  /// Unique identifier - uses DHIS2 UID format when possible
  /// Falls back to auto-increment for local-only entities
  Id? id = Isar.autoIncrement;

  /// DHIS2 UID - the actual DHIS2 identifier  
  @Index()
  late String dhis2Id;

  /// Indicates if the entity has local changes not yet synced
  @Index()
  late bool dirty;

  /// Timestamp when the entity was created
  @Index()
  late int createdTimestamp;

  /// Timestamp when the entity was last updated
  @Index()
  late int lastUpdatedTimestamp;

  /// Indicates if the entity has been synced with the server
  @Index()
  late bool synced;

  /// Server-provided created timestamp (ISO string)
  String? serverCreated;

  /// Server-provided last updated timestamp (ISO string)  
  String? serverLastUpdated;

  BaseIsarEntity() {
    final now = DateTime.now().millisecondsSinceEpoch;
    createdTimestamp = now;
    lastUpdatedTimestamp = now;
    dirty = true;
    synced = false;
  }

  /// Get created date as DateTime
  DateTime get createdAt => DateTime.fromMillisecondsSinceEpoch(createdTimestamp);

  /// Get last updated date as DateTime
  DateTime get lastUpdatedAt => DateTime.fromMillisecondsSinceEpoch(lastUpdatedTimestamp);

  /// Set created date from DateTime
  set createdAt(DateTime dateTime) {
    createdTimestamp = dateTime.millisecondsSinceEpoch;
  }

  /// Set last updated date from DateTime
  set lastUpdatedAt(DateTime dateTime) {
    lastUpdatedTimestamp = dateTime.millisecondsSinceEpoch;
  }

  /// Mark entity as dirty (has local changes)
  void markDirty() {
    dirty = true;
    synced = false;
    lastUpdatedTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  /// Mark entity as synced (no local changes)
  void markSynced() {
    dirty = false;
    synced = true;
  }

  /// Update timestamps
  void updateTimestamp() {
    lastUpdatedTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  /// Convert to JSON for API communication
  Map<String, dynamic> toJson();

  /// Create from API JSON response
  static BaseIsarEntity fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('Subclasses must implement fromJson');
  }

  /// Check if entity is valid DHIS2 entity
  bool get isValidDhis2Entity {
    return dhis2Id.isNotEmpty && _isValidDhis2Uid(dhis2Id);
  }

  /// Validate DHIS2 UID format
  bool _isValidDhis2Uid(String uid) {
    if (uid.isEmpty) return false;
    // DHIS2 UIDs are 11 characters: letter followed by 10 alphanumeric
    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9]{10}$');
    return regex.hasMatch(uid);
  }

  /// Get display name for UI
  String get displayName => dhis2Id;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseIsarEntity &&
           other.dhis2Id == dhis2Id &&
           other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => dhis2Id.hashCode;

  @override
  String toString() {
    return '${runtimeType.toString()}(dhis2Id: $dhis2Id, dirty: $dirty, synced: $synced)';
  }
}

/// Identifiable Isar Entity
/// 
/// Extended base class for entities that have name and display properties
/// Equivalent to IdentifiableEntity in the original codebase
abstract class IdentifiableIsarEntity extends BaseIsarEntity {
  /// Entity name
  @Index(type: IndexType.value)
  late String name;

  /// Display name (optional, falls back to name)
  String? displayNameValue;

  /// Short name (optional)
  String? shortName;

  /// Code (optional, but indexed for quick lookup)
  @Index()
  String? code;

  /// Description (optional)
  String? description;

  IdentifiableIsarEntity() : super();

  /// Get effective display name
  String get effectiveDisplayName => displayNameValue ?? name;

  /// Get effective short name  
  String get effectiveShortName => shortName ?? name;

  @override
  String get displayName => effectiveDisplayName;

  /// Search helper - combines all searchable text
  String get searchableText {
    final parts = <String>[
      name,
      if (displayNameValue != null) displayNameValue!,
      if (shortName != null) shortName!,
      if (code != null) code!,
      if (description != null) description!,
    ];
    return parts.join(' ').toLowerCase();
  }

  @override
  String toString() {
    return '${runtimeType.toString()}(dhis2Id: $dhis2Id, name: $name)';
  }
}

/// Mixin for entities with geographical information
mixin GeographyMixin {
  /// Latitude coordinate
  double? latitude;

  /// Longitude coordinate  
  double? longitude;

  /// Get coordinates as a map
  @ignore
  Map<String, double>? get coordinates {
    if (latitude != null && longitude != null) {
      return {'latitude': latitude!, 'longitude': longitude!};
    }
    return null;
  }

  /// Set coordinates from map
  set coordinates(Map<String, double>? coords) {
    if (coords != null) {
      latitude = coords['latitude'];
      longitude = coords['longitude'];
    } else {
      latitude = null;
      longitude = null;
    }
  }

  /// Check if entity has coordinates
  bool get hasCoordinates => latitude != null && longitude != null;
}

/// Mixin for entities with hierarchical relationships
mixin HierarchicalMixin {
  /// Parent entity DHIS2 ID
  @Index()
  String? parentId;

  /// Path in the hierarchy (e.g., "/parent/child/grandchild")
  String? path;

  /// Level in the hierarchy (root = 1)
  int? level;

  /// Check if this is a root entity
  bool get isRoot => parentId == null || parentId!.isEmpty;

  /// Check if this is a leaf entity (has no children)
  /// Note: This would need to be determined by querying for children
  /// Implementation depends on specific use case
}

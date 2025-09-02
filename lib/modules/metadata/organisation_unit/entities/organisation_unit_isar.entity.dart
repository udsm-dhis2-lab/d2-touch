import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

part 'organisation_unit_isar.entity.g.dart';

/// OrganisationUnit Isar Collection
/// 
/// Replaces the SQLite-based OrganisationUnit entity with Isar collection
/// Handles DHIS2 organisation unit hierarchy, geography, and metadata
@collection
class OrganisationUnitIsar extends IdentifiableIsarEntity with HierarchicalMixin, GeographyMixin {
  /// Organisation unit level in hierarchy (root = 1)
  @Index()
  int? level;

  /// Path in hierarchy (e.g. "/root/country/region/district")
  @Index(type: IndexType.value)
  String? path;

  /// External access permission
  bool? externalAccess;

  /// Opening date (ISO string format)
  String? openingDate;

  /// Opening date timestamp for efficient queries
  @Index()
  int? openingDateTimestamp;

  /// Serialized geometry JSON (coordinates, type, etc.)
  String? geometryJson;

  /// Parent organisation unit ID
  @override
  @Index()
  String? parentId;

  /// Serialized translations JSON
  String? translationsJson;

  /// Children organisation unit IDs (cached for performance)
  List<String>? childrenIds;

  /// Cached ancestor IDs for hierarchy queries
  List<String>? ancestorIds;

  /// Is this a leaf node (has no children)
  @Index()
  late bool isLeaf;

  /// Is this a root node (has no parent)
  @Index()
  bool get isRoot => parentId == null || parentId!.isEmpty;

  OrganisationUnitIsar() : super() {
    isLeaf = true;
    childrenIds = [];
    ancestorIds = [];
  }

  /// Get opening date as DateTime
  DateTime? get openingDate_DateTime {
    if (openingDate != null) {
      try {
        return DateTime.parse(openingDate!);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Set opening date from DateTime
  set openingDate_DateTime(DateTime? dateTime) {
    if (dateTime != null) {
      openingDate = dateTime.toIso8601String();
      openingDateTimestamp = dateTime.millisecondsSinceEpoch;
    } else {
      openingDate = null;
      openingDateTimestamp = null;
    }
  }

  /// Get geometry from JSON
  @ignore
  Map<String, dynamic>? get geometry {
    if (geometryJson == null || geometryJson!.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(geometryJson!) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Set geometry as JSON
  set geometry(Map<String, dynamic>? geom) {
    if (geom != null) {
      geometryJson = jsonEncode(geom);
      // Extract coordinates if available
      if (geom['coordinates'] != null && geom['coordinates'] is List) {
        final coords = geom['coordinates'] as List;
        
        // Handle different geometry types
        if (geom['type'] == 'Point' && coords.length >= 2) {
          // Point coordinates: [longitude, latitude]
          final lon = coords[0];
          final lat = coords[1];
          if (lon is num) longitude = lon.toDouble();
          if (lat is num) latitude = lat.toDouble();
        } else if ((geom['type'] == 'Polygon' || geom['type'] == 'MultiPolygon') && coords.isNotEmpty) {
          // For polygons, get first coordinate of first ring
          var firstCoord = coords[0];
          if (firstCoord is List && firstCoord.isNotEmpty) {
            var point = firstCoord[0];
            if (point is List && point.length >= 2) {
              final lon = point[0];
              final lat = point[1];
              if (lon is num) longitude = lon.toDouble();
              if (lat is num) latitude = lat.toDouble();
            }
          }
        }
      }
    } else {
      geometryJson = null;
      longitude = null;
      latitude = null;
    }
  }

  /// Get translations from JSON
  @ignore
  Map<String, dynamic>? get translations {
    if (translationsJson == null || translationsJson!.isEmpty) {
      return null;
    }
    try {
      return jsonDecode(translationsJson!) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Set translations as JSON
  set translations(Map<String, dynamic>? trans) {
    if (trans != null) {
      translationsJson = jsonEncode(trans);
    } else {
      translationsJson = null;
    }
  }

  /// Update hierarchy information
  void updateHierarchy({
    String? parentId,
    int? level,
    String? path,
    List<String>? ancestorIds,
  }) {
    if (parentId != null) this.parentId = parentId;
    if (level != null) this.level = level;
    if (path != null) this.path = path;
    if (ancestorIds != null) this.ancestorIds = ancestorIds;
    
    markDirty();
  }

  /// Add child organisation unit
  void addChild(String childId) {
    childrenIds ??= [];
    if (!childrenIds!.contains(childId)) {
      childrenIds!.add(childId);
      isLeaf = false;
      markDirty();
    }
  }

  /// Remove child organisation unit
  void removeChild(String childId) {
    childrenIds?.remove(childId);
    isLeaf = childrenIds?.isEmpty ?? true;
    markDirty();
  }

  /// Check if this organisation unit is ancestor of another
  bool isAncestorOf(OrganisationUnitIsar other) {
    return other.ancestorIds?.contains(dhis2Id) ?? false;
  }

  /// Check if this organisation unit is descendant of another
  bool isDescendantOf(OrganisationUnitIsar other) {
    return ancestorIds?.contains(other.dhis2Id) ?? false;
  }

  /// Get hierarchy level display (e.g., "Level 3 - District")
  String get hierarchyDisplay {
    final levelText = level != null ? "Level $level" : "Unknown Level";
    return "$levelText - $name";
  }

  /// Factory constructor from JSON (DHIS2 API response)
  factory OrganisationUnitIsar.fromApi(Map<String, dynamic> json) {
    final orgUnit = OrganisationUnitIsar();
    
    orgUnit.dhis2Id = json['id'] ?? '';
    orgUnit.name = json['name'] ?? '';
    orgUnit.shortName = json['shortName'];
    orgUnit.displayNameValue = json['displayName'];
    orgUnit.code = json['code'];
    orgUnit.description = json['description'];
    
    orgUnit.level = json['level'];
    orgUnit.path = json['path'];
    orgUnit.externalAccess = json['externalAccess'];
    orgUnit.openingDate = json['openingDate'];
    
    // Parse opening date timestamp
    if (json['openingDate'] != null) {
      try {
        final date = DateTime.parse(json['openingDate']);
        orgUnit.openingDateTimestamp = date.millisecondsSinceEpoch;
      } catch (e) {
        // Invalid date format, keep null
      }
    }
    
    // Handle parent
    final parent = json['parent'];
    if (parent != null) {
      orgUnit.parentId = parent is String ? parent : parent['id'];
    }
    
    // Handle geometry
    if (json['geometry'] != null) {
      orgUnit.geometry = json['geometry'] as Map<String, dynamic>;
    }
    
    // Handle translations
    if (json['translations'] != null) {
      orgUnit.translations = json['translations'] as Map<String, dynamic>;
    }
    
    // Handle timestamps
    if (json['created'] != null) {
      orgUnit.serverCreated = json['created'];
      try {
        orgUnit.createdAt = DateTime.parse(json['created']);
      } catch (e) {
        // Keep default timestamp
      }
    }
    
    if (json['lastUpdated'] != null) {
      orgUnit.serverLastUpdated = json['lastUpdated'];
      try {
        orgUnit.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {
        // Keep default timestamp
      }
    }
    
    orgUnit.dirty = json['dirty'] ?? false;
    
    // Build ancestor IDs from path
    if (orgUnit.path != null) {
      orgUnit.ancestorIds = orgUnit.path!
          .split('/')
          .where((id) => id.isNotEmpty && id != orgUnit.dhis2Id)
          .toList();
    }
    
    return orgUnit;
  }

  /// Factory constructor from JSON (local storage)
  factory OrganisationUnitIsar.fromJson(Map<String, dynamic> json) {
    final orgUnit = OrganisationUnitIsar();
    
    orgUnit.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    orgUnit.name = json['name'] ?? '';
    orgUnit.shortName = json['shortName'];
    orgUnit.displayNameValue = json['displayName'];
    orgUnit.code = json['code'];
    orgUnit.description = json['description'];
    
    orgUnit.level = json['level'];
    orgUnit.path = json['path'];
    orgUnit.parentId = json['parentId'];
    orgUnit.externalAccess = json['externalAccess'];
    orgUnit.openingDate = json['openingDate'];
    orgUnit.openingDateTimestamp = json['openingDateTimestamp'];
    
    orgUnit.geometryJson = json['geometryJson'];
    orgUnit.translationsJson = json['translationsJson'];
    
    // Parse coordinates
    orgUnit.latitude = json['latitude']?.toDouble();
    orgUnit.longitude = json['longitude']?.toDouble();
    
    // Parse collections
    if (json['childrenIds'] != null) {
      orgUnit.childrenIds = (json['childrenIds'] as List).cast<String>();
    }
    
    if (json['ancestorIds'] != null) {
      orgUnit.ancestorIds = (json['ancestorIds'] as List).cast<String>();
    }
    
    orgUnit.isLeaf = json['isLeaf'] ?? true;
    
    // Timestamps
    orgUnit.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    orgUnit.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    
    orgUnit.dirty = json['dirty'] ?? false;
    orgUnit.synced = json['synced'] ?? false;
    orgUnit.serverCreated = json['serverCreated'];
    orgUnit.serverLastUpdated = json['serverLastUpdated'];
    
    return orgUnit;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'shortName': shortName,
      'displayName': displayName,
      'code': code,
      'description': description,
      'level': level,
      'path': path,
      'parentId': parentId,
      'externalAccess': externalAccess,
      'openingDate': openingDate,
      'openingDateTimestamp': openingDateTimestamp,
      'geometryJson': geometryJson,
      'translationsJson': translationsJson,
      'latitude': latitude,
      'longitude': longitude,
      'childrenIds': childrenIds,
      'ancestorIds': ancestorIds,
      'isLeaf': isLeaf,
      'createdTimestamp': createdTimestamp,
      'lastUpdatedTimestamp': lastUpdatedTimestamp,
      'dirty': dirty,
      'synced': synced,
      'serverCreated': serverCreated,
      'serverLastUpdated': serverLastUpdated,
    };
  }

  @override
  String toString() {
    return 'OrganisationUnitIsar(dhis2Id: $dhis2Id, name: $name, level: $level, path: $path)';
  }
}

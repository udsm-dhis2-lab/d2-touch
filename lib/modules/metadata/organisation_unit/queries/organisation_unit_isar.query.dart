import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/core/utilities/isar_repository.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:d2_touch/shared/utilities/save_option.util.dart';

/// OrganisationUnitIsar Query Class
/// 
/// Specialized query class for OrganisationUnitIsar entity with hierarchical and geographic operations
/// Provides organization unit hierarchy navigation, level filtering, and geographic queries
class OrganisationUnitIsarQuery {
  final IsarManager isarManager;
  final IsarRepository<OrganisationUnitIsar> repository;
  
  // Query state
  dynamic data;
  List<String> selected = const [];
  MergeMode _mergeMode = MergeMode.Replace;

  OrganisationUnitIsarQuery({
    required this.isarManager,
  }) : repository = IsarRepository<OrganisationUnitIsar>(
          isarManager: isarManager,
          collection: isarManager.database.then((isar) => isar.organisationUnitIsars),
        );

  /// Set merge mode for save operations
  set mergeMode(MergeMode mergeMode) {
    _mergeMode = mergeMode;
  }

  /// Select specific fields for API queries
  OrganisationUnitIsarQuery select(List<String> fields) {
    selected = fields;
    return this;
  }

  /// Set data for save operations
  OrganisationUnitIsarQuery setData(dynamic data) {
    this.data = data;
    return this;
  }

  /// Get organization unit by ID
  Future<OrganisationUnitIsar?> byId(String orgUnitId) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .dhis2IdEqualTo(orgUnitId)
          .findFirst();
    });
  }

  /// Get organization units by multiple IDs
  Future<List<OrganisationUnitIsar>> byIds(List<String> orgUnitIds) async {
    if (orgUnitIds.isEmpty) return [];
    
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .anyOf(orgUnitIds, (q, id) => q.dhis2IdEqualTo(id))
          .findAll();
    });
  }

  /// Get organization units by level
  Future<List<OrganisationUnitIsar>> byLevel(int level) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .levelEqualTo(level)
          .sortByName()
          .findAll();
    });
  }

  /// Get organization units by level range
  Future<List<OrganisationUnitIsar>> byLevelRange(int minLevel, int maxLevel) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .levelBetween(minLevel, maxLevel)
          .sortByLevel()
          .thenByName()
          .findAll();
    });
  }

  /// Get root organization units (no parent)
  Future<List<OrganisationUnitIsar>> getRoots() async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .parentIdIsNull()
          .sortByName()
          .findAll();
    });
  }

  /// Get leaf organization units (no children)
  Future<List<OrganisationUnitIsar>> getLeaves() async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .isLeafEqualTo(true)
          .sortByName()
          .findAll();
    });
  }

  /// Get direct children of an organization unit
  Future<List<OrganisationUnitIsar>> getChildren(String parentId) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .parentIdEqualTo(parentId)
          .sortByLevel()
          .thenByName()
          .findAll();
    });
  }

  /// Get all descendants of an organization unit (recursive)
  Future<List<OrganisationUnitIsar>> getDescendants(String ancestorId) async {
    return await isarManager.readTxn((isar) async {
      final orgUnits = await isar.organisationUnitIsars.where().findAll();
      return orgUnits.where((ou) => 
        ou.ancestorIds?.contains(ancestorId) ?? false
      ).toList();
    });
  }

  /// Get ancestors of an organization unit
  Future<List<OrganisationUnitIsar>> getAncestors(String orgUnitId) async {
    return await isarManager.readTxn((isar) async {
      final orgUnit = await isar.organisationUnitIsars
          .filter()
          .dhis2IdEqualTo(orgUnitId)
          .findFirst();
          
      if (orgUnit?.ancestorIds == null || orgUnit!.ancestorIds!.isEmpty) {
        return [];
      }
      
      return await isar.organisationUnitIsars
          .filter()
          .anyOf(orgUnit.ancestorIds!, (q, id) => q.dhis2IdEqualTo(id))
          .sortByLevel()
          .findAll();
    });
  }

  /// Get siblings of an organization unit (same parent)
  Future<List<OrganisationUnitIsar>> getSiblings(String orgUnitId, {bool includeSelf = false}) async {
    return await isarManager.readTxn((isar) async {
      final orgUnit = await isar.organisationUnitIsars
          .filter()
          .dhis2IdEqualTo(orgUnitId)
          .findFirst();
          
      if (orgUnit?.parentId == null) {
        return []; // Root units have no siblings
      }
      
      var query = isar.organisationUnitIsars
          .filter()
          .parentIdEqualTo(orgUnit!.parentId!);
          
      if (!includeSelf) {
        query = query.not().dhis2IdEqualTo(orgUnitId);
      }
      
      return await query.sortByName().findAll();
    });
  }

  /// Get organization units by name pattern
  Future<List<OrganisationUnitIsar>> searchByName(String namePattern) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .nameContains(namePattern, caseSensitive: false)
          .or()
          .shortNameIsNotNull()
          .and()
          .shortNameContains(namePattern, caseSensitive: false)
          .or()
          .displayNameIsNotNull()
          .and()
          .displayNameContains(namePattern, caseSensitive: false)
          .sortByName()
          .findAll();
    });
  }

  /// Get organization units by code
  Future<List<OrganisationUnitIsar>> byCode(String code) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .codeEqualTo(code)
          .findAll();
    });
  }

  /// Get organization units within geographic bounds
  Future<List<OrganisationUnitIsar>> withinBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) async {
    return await isarManager.readTxn((isar) async {
      final orgUnits = await isar.organisationUnitIsars.where().findAll();
      return orgUnits.where((ou) {
        if (!ou.hasCoordinates) return false;
        return ou.latitude! >= minLat && 
               ou.latitude! <= maxLat &&
               ou.longitude! >= minLng && 
               ou.longitude! <= maxLng;
      }).toList();
    });
  }

  /// Get organization units with coordinates
  Future<List<OrganisationUnitIsar>> withCoordinates() async {
    return await isarManager.readTxn((isar) async {
      final orgUnits = await isar.organisationUnitIsars.where().findAll();
      return orgUnits.where((ou) => ou.hasCoordinates).toList();
    });
  }

  /// Get organization units opened after date
  Future<List<OrganisationUnitIsar>> openedAfter(DateTime date) async {
    return await isarManager.readTxn((isar) async {
      final timestamp = date.millisecondsSinceEpoch;
      return await isar.organisationUnitIsars
          .filter()
          .openingDateTimestampIsNotNull()
          .and()
          .openingDateTimestampGreaterThan(timestamp)
          .sortByOpeningDateTimestamp()
          .findAll();
    });
  }

  /// Get organization units opened before date
  Future<List<OrganisationUnitIsar>> openedBefore(DateTime date) async {
    return await isarManager.readTxn((isar) async {
      final timestamp = date.millisecondsSinceEpoch;
      return await isar.organisationUnitIsars
          .filter()
          .openingDateTimestampIsNotNull()
          .and()
          .openingDateTimestampLessThan(timestamp)
          .sortByOpeningDateTimestamp()
          .findAll();
    });
  }

  /// Get all organization units
  Future<List<OrganisationUnitIsar>> get({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      return await fetchOnline(dioTestClient: dioTestClient);
    }

    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .where()
          .sortByLevel()
          .thenByName()
          .findAll();
    });
  }

  /// Get single organization unit
  Future<OrganisationUnitIsar?> getOne({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      final results = await fetchOnline(dioTestClient: dioTestClient);
      return results.isNotEmpty ? results.first : null;
    }

    final results = await get();
    return results.isNotEmpty ? results.first : null;
  }

  /// Watch organization units (reactive stream)
  Stream<List<OrganisationUnitIsar>> watch({bool fireImmediately = true}) {
    final isar = isarManager.database;
    return isar.asStream().asyncMap((db) => 
      db.organisationUnitIsars
          .where()
          .sortByLevel()
          .thenByName()
          .watch(fireImmediately: fireImmediately)
    ).asyncExpand((stream) => stream);
  }

  /// Watch organization unit by ID
  Stream<OrganisationUnitIsar?> watchById(String orgUnitId, {bool fireImmediately = true}) {
    final isar = isarManager.database;
    return isar.asStream().asyncMap((db) => 
      db.organisationUnitIsars
          .filter()
          .dhis2IdEqualTo(orgUnitId)
          .watch(fireImmediately: fireImmediately)
          .map((orgUnits) => orgUnits.isNotEmpty ? orgUnits.first : null)
    ).asyncExpand((stream) => stream);
  }

  /// Watch children of organization unit
  Stream<List<OrganisationUnitIsar>> watchChildren(String parentId, {bool fireImmediately = true}) {
    final isar = isarManager.database;
    return isar.asStream().asyncMap((db) => 
      db.organisationUnitIsars
          .filter()
          .parentIdEqualTo(parentId)
          .sortByLevel()
          .thenByName()
          .watch(fireImmediately: fireImmediately)
    ).asyncExpand((stream) => stream);
  }

  /// Save organization unit data
  Future<int> save({SaveOptions? saveOptions}) async {
    if (data is List) {
      final orgUnits = data as List<OrganisationUnitIsar>;
      
      // Update hierarchy relationships before saving
      await _updateHierarchyRelationships(orgUnits);
      
      return await repository.saveMany(
        entities: orgUnits,
        mergeMode: _mergeMode,
        saveOptions: saveOptions,
      );
    }
    
    if (data != null) {
      final orgUnit = data as OrganisationUnitIsar;
      orgUnit.updateTimestamp();
      
      await repository.saveOne(
        entity: orgUnit,
        mergeMode: _mergeMode,
        saveOptions: saveOptions,
      );
      return 1;
    }
    
    return 0;
  }

  /// Update hierarchy relationships for all organization units
  Future<void> _updateHierarchyRelationships(List<OrganisationUnitIsar> orgUnits) async {
    final orgUnitMap = {for (var ou in orgUnits) ou.dhis2Id: ou};
    
    // Update children relationships
    for (final orgUnit in orgUnits) {
      if (orgUnit.parentId != null) {
        final parent = orgUnitMap[orgUnit.parentId];
        if (parent != null) {
          parent.addChild(orgUnit.dhis2Id);
        }
      }
    }
  }

  /// Count organization units
  Future<int> count() async {
    return await repository.count();
  }

  /// Count by level
  Future<int> countByLevel(int level) async {
    return await isarManager.readTxn((isar) async {
      return await isar.organisationUnitIsars
          .filter()
          .levelEqualTo(level)
          .count();
    });
  }

  /// Delete organization unit
  Future<bool> delete(String orgUnitId) async {
    return await repository.deleteById(orgUnitId);
  }

  /// Delete all organization units
  Future<int> deleteAll() async {
    return await repository.deleteAll();
  }

  /// Fetch organization units from DHIS2 API
  Future<List<OrganisationUnitIsar>> fetchOnline({Dio? dioTestClient}) async {
    try {
      final url = await dhisUrl();
      final response = await HttpClient.get(
        url,
        database: null,
        dioTestClient: dioTestClient,
      );

      List data = response.body != null && response.body['organisationUnits'] != null
          ? response.body['organisationUnits']?.toList() ?? []
          : [];

      return data.map((orgUnitJson) {
        orgUnitJson['dirty'] = false;
        orgUnitJson['synced'] = true;
        return OrganisationUnitIsar.fromApi(orgUnitJson);
      }).toList();
    } catch (e) {
      print('Error fetching organization units online: $e');
      return [];
    }
  }

  /// Download organization units from API and save to database
  Future<List<OrganisationUnitIsar>?> download(
    Function(RequestProgress, bool) callback, {
    Dio? dioTestClient,
  }) async {
    callback(
      RequestProgress(
        resourceName: 'organisationUnits',
        message: 'Downloading organisation units from the server....',
        status: '',
        percentage: 0,
      ),
      false,
    );

    final orgUnits = await fetchOnline(dioTestClient: dioTestClient);

    if (orgUnits.isEmpty) {
      callback(
        RequestProgress(
          resourceName: 'organisationUnits',
          message: 'No organisation units found.',
          status: '',
          percentage: 100,
        ),
        true,
      );
      return [];
    }

    callback(
      RequestProgress(
        resourceName: 'organisationUnits',
        message: '${orgUnits.length} organisation units downloaded successfully',
        status: '',
        percentage: 50,
      ),
      false,
    );

    callback(
      RequestProgress(
        resourceName: 'organisationUnits',
        message: 'Saving ${orgUnits.length} organisation units into database...',
        status: '',
        percentage: 51,
      ),
      false,
    );

    data = orgUnits;
    await save();

    callback(
      RequestProgress(
        resourceName: 'organisationUnits',
        message: '${orgUnits.length} organisation units successfully saved',
        status: '',
        percentage: 100,
      ),
      true,
    );

    return orgUnits;
  }

  /// Generate DHIS2 API URL for organization unit queries
  Future<String> dhisUrl() async {
    final baseFields = [
      'id', 'name', 'shortName', 'displayName', 'code', 'description',
      'created', 'lastUpdated', 'level', 'path', 'externalAccess',
      'openingDate', 'parent[id]', 'geometry', 'translations'
    ];

    final fields = selected.isNotEmpty ? selected : baseFields;

    return 'organisationUnits.json?fields=${fields.join(',')}&paging=false';
  }

  /// Create table (compatibility method)
  Future<void> createTable() async {
    await repository.create();
  }

  /// Get hierarchy statistics
  Future<Map<String, dynamic>> getHierarchyStats() async {
    return await isarManager.readTxn((isar) async {
      final allOrgUnits = await isar.organisationUnitIsars.where().findAll();
      
      final levelCounts = <int, int>{};
      int rootCount = 0;
      int leafCount = 0;
      int withCoordinatesCount = 0;
      
      for (final ou in allOrgUnits) {
        if (ou.level != null) {
          levelCounts[ou.level!] = (levelCounts[ou.level!] ?? 0) + 1;
        }
        if (ou.isRoot) rootCount++;
        if (ou.isLeaf) leafCount++;
        if (ou.hasCoordinates) withCoordinatesCount++;
      }
      
      return {
        'total': allOrgUnits.length,
        'roots': rootCount,
        'leaves': leafCount,
        'withCoordinates': withCoordinatesCount,
        'levels': levelCounts,
        'maxLevel': levelCounts.keys.isNotEmpty ? levelCounts.keys.reduce((a, b) => a > b ? a : b) : 0,
      };
    });
  }
}

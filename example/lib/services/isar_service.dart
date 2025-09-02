import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
// Add more imports for comprehensive metadata stats
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';

class IsarService {
  static late Isar _isar;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [UserIsarSchema, OrganisationUnitIsarSchema],
      directory: dir.path,
      name: 'd2_touch_sample',
    );
    
    _isInitialized = true;
  }

  static Isar get instance {
    if (!_isInitialized) {
      throw Exception('IsarService not initialized. Call initialize() first.');
    }
    return _isar;
  }

  // User operations
  static Future<void> saveUser(UserIsar user) async {
    await _isar.writeTxn(() async {
      await _isar.userIsars.put(user);
    });
  }

  static Future<UserIsar?> getCurrentUser() async {
    return await _isar.userIsars.where().isLoggedInEqualTo(true).findFirst();
  }

  static Future<void> logoutUser() async {
    await _isar.writeTxn(() async {
      final users = await _isar.userIsars.where().isLoggedInEqualTo(true).findAll();
      for (final user in users) {
        user.isLoggedIn = false;
        user.token = null;
        user.tokenExpiresAtTimestamp = null;
        await _isar.userIsars.put(user);
      }
    });
  }

  static Future<List<UserIsar>> getAllUsers() async {
    return await _isar.userIsars.where().findAll();
  }

  // Organisation Unit operations
  static Future<void> saveOrganisationUnit(OrganisationUnitIsar orgUnit) async {
    await _isar.writeTxn(() async {
      await _isar.organisationUnitIsars.put(orgUnit);
    });
  }

  static Future<void> saveOrganisationUnits(List<OrganisationUnitIsar> orgUnits) async {
    await _isar.writeTxn(() async {
      await _isar.organisationUnitIsars.putAll(orgUnits);
    });
  }

  static Future<List<OrganisationUnitIsar>> getAllOrganisationUnits() async {
    return await _isar.organisationUnitIsars.where().findAll();
  }

  static Future<List<OrganisationUnitIsar>> getOrganisationUnitsByLevel(int level) async {
    return await _isar.organisationUnitIsars.where().levelEqualTo(level).findAll();
  }

  static Future<OrganisationUnitIsar?> getOrganisationUnitById(String id) async {
    return await _isar.organisationUnitIsars.where().dhis2IdEqualTo(id).findFirst();
  }

  // Statistics
  static Future<Map<String, int>> getDatabaseStats() async {
    final userCount = await _isar.userIsars.count();
    final orgUnitCount = await _isar.organisationUnitIsars.count();
    
    return {
      'users': userCount,
      'organisationUnits': orgUnitCount,
    };
  }

  // Database maintenance
  static Future<void> clearAllData() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }

  static Future<void> close() async {
    if (_isInitialized) {
      await _isar.close();
      _isInitialized = false;
    }
  }

  // Sync status helpers
  static Future<List<UserIsar>> getDirtyUsers() async {
    return await _isar.userIsars.where().dirtyEqualTo(true).findAll();
  }

  static Future<List<OrganisationUnitIsar>> getDirtyOrganisationUnits() async {
    return await _isar.organisationUnitIsars.where().dirtyEqualTo(true).findAll();
  }

  static Future<void> markAllAsSynced() async {
    await _isar.writeTxn(() async {
      // Mark all users as synced
      final dirtyUsers = await getDirtyUsers();
      for (final user in dirtyUsers) {
        user.markSynced();
        await _isar.userIsars.put(user);
      }

      // Mark all org units as synced
      final dirtyOrgUnits = await getDirtyOrganisationUnits();
      for (final orgUnit in dirtyOrgUnits) {
        orgUnit.markSynced();
        await _isar.organisationUnitIsars.put(orgUnit);
      }
    });
  }
}

library d2_touch_isar;

import 'package:d2_touch/core/database/database.util.dart';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/core/models/d2_touch.model.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/auth/queries/user_isar.query.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/queries/organisation_unit_isar.query.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enhanced D2Touch with Isar Support
/// 
/// This class provides both SQLite and Isar database support for the DHIS2 Flutter SDK
/// Allows gradual migration from SQLite to Isar with feature flags and compatibility
class D2TouchIsar {
  // Configuration
  int? instanceVersion;
  String locale = 'en';
  bool useIsar = false; // Feature flag for Isar migration
  bool? inMemory;
  
  // Database managers
  IsarManager? _isarManager;
  late SharedPreferences sharedPreferenceInstance;
  
  // Singleton
  static D2TouchIsar? _d2Instance;

  D2TouchIsar._internal();

  /// Factory constructor to initialize D2TouchIsar
  /// 
  /// Parameters:
  /// - useIsar: Whether to use Isar database instead of SQLite
  /// - instanceVersion: DHIS2 instance version
  /// - locale: Localization setting
  /// - databaseName: Custom database name
  /// - inMemory: Use in-memory database for testing
  static Future<D2TouchIsar> init({
    bool useIsar = false,
    int? instanceVersion,
    String? locale,
    String? databaseName,
    bool? inMemory,
    SharedPreferences? sharedPreferenceInstance,
  }) async {
    if (_d2Instance == null) {
      _d2Instance = D2TouchIsar._internal();

      _d2Instance!.useIsar = useIsar;
      _d2Instance!.locale = locale ?? 'en';
      _d2Instance!.instanceVersion = instanceVersion;
      _d2Instance!.inMemory = inMemory;
      
      _d2Instance!.sharedPreferenceInstance =
          sharedPreferenceInstance ?? await SharedPreferences.getInstance();

      final newDatabaseName =
          databaseName ?? await DatabaseUtil.getDatabaseName();

      if (newDatabaseName != null) {
        if (useIsar) {
          await _d2Instance!._initializeIsar(
            databaseName: newDatabaseName,
            inMemory: inMemory ?? false,
          );
        } else {
          // Keep existing SQLite initialization for compatibility
          throw UnimplementedError('SQLite support maintained in original D2Touch class');
        }
      }
    }

    return _d2Instance!;
  }

  /// Initialize Isar database with all schemas
  Future<void> _initializeIsar({
    required String databaseName,
    required bool inMemory,
  }) async {
    // Define all Isar schemas
    final schemas = <CollectionSchema<dynamic>>[
      UserIsarSchema,
      OrganisationUnitIsarSchema,
      // Add more schemas as they are converted
      // TrackedEntityIsarSchema,
      // ProgramIsarSchema,
      // etc.
    ];

    _isarManager = IsarManager(
      databaseName: databaseName,
      schemas: schemas,
      inMemory: inMemory,
    );

    // Initialize the database
    await _isarManager!.database;
    
    if (kDebugMode) {
      final stats = await _isarManager!.getStats();
      print('Isar database initialized: ${stats['databaseName']}');
      print('Database size: ${stats['sizeFormatted']}');
    }
  }

  /// Get Isar manager instance
  IsarManager get isarManager {
    if (_isarManager == null) {
      throw StateError('Isar not initialized. Call D2TouchIsar.init() with useIsar: true first.');
    }
    return _isarManager!;
  }

  // ========== ISAR MODULE GETTERS ==========

  /// Get UserIsar query module
  UserIsarQuery get userIsarQuery {
    if (!useIsar) {
      throw StateError('Isar not enabled. Set useIsar: true in D2TouchIsar.init()');
    }
    return UserIsarQuery(isarManager: isarManager);
  }

  /// Get OrganisationUnitIsar query module
  OrganisationUnitIsarQuery get organisationUnitIsarQuery {
    if (!useIsar) {
      throw StateError('Isar not enabled. Set useIsar: true in D2TouchIsar.init()');
    }
    return OrganisationUnitIsarQuery(isarManager: isarManager);
  }

  // TODO: Add more Isar module getters as entities are converted
  // TrackedEntityIsarQuery get trackedEntityIsarQuery => ...
  // ProgramIsarQuery get programIsarQuery => ...

  // ========== DATABASE MANAGEMENT ==========

  /// Get current logged in user (Isar)
  Future<UserIsar?> getCurrentUser() async {
    if (!useIsar) {
      throw StateError('Isar not enabled. Use original D2Touch for SQLite operations.');
    }
    
    return await userIsarQuery.getLoggedInUser();
  }

  /// Login user with Isar
  Future<UserIsar> loginUser(UserIsar user) async {
    if (!useIsar) {
      throw StateError('Isar not enabled. Use original D2Touch for SQLite operations.');
    }
    
    return await userIsarQuery.loginUser(user);
  }

  /// Logout all users (Isar)
  Future<void> logoutAllUsers() async {
    if (!useIsar) {
      throw StateError('Isar not enabled. Use original D2Touch for SQLite operations.');
    }
    
    await userIsarQuery.logoutAllUsers();
  }

  /// Check if user is authenticated (Isar)
  Future<bool> isAuthenticated() async {
    if (!useIsar) {
      throw StateError('Isar not enabled. Use original D2Touch for SQLite operations.');
    }
    
    final user = await getCurrentUser();
    return user != null && user.isLoggedIn && !user.isTokenExpired;
  }

  /// Get database statistics
  Future<Map<String, dynamic>> getDatabaseStats() async {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    return await isarManager.getStats();
  }

  /// Compact database for better performance
  Future<void> compactDatabase() async {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    await isarManager.compact();
    
    if (kDebugMode) {
      final stats = await getDatabaseStats();
      print('Database compacted. New size: ${stats['sizeFormatted']}');
    }
  }

  // ========== MIGRATION UTILITIES ==========

  /// Migrate data from SQLite to Isar
  /// This is a placeholder for the migration utility
  Future<void> migrateFromSQLite({
    required String sqliteDatabasePath,
    Function(String message, double progress)? onProgress,
  }) async {
    if (!useIsar) {
      throw StateError('Isar not enabled. Cannot perform migration.');
    }
    
    onProgress?.call('Starting migration from SQLite to Isar...', 0.0);
    
    // TODO: Implement actual migration logic
    // 1. Read data from SQLite database
    // 2. Convert to Isar entities
    // 3. Save to Isar database
    // 4. Validate data integrity
    
    throw UnimplementedError('Migration utility to be implemented');
  }

  /// Export Isar data to JSON for backup
  Future<Map<String, dynamic>> exportToJson() async {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    return await isarManager.readTxn((isar) async {
      final users = await isar.userIsars.where().findAll();
      final orgUnits = await isar.organisationUnitIsars.where().findAll();
      
      return {
        'metadata': {
          'exportDate': DateTime.now().toIso8601String(),
          'databaseName': isarManager.databaseName,
          'totalEntities': users.length + orgUnits.length,
        },
        'users': users.map((u) => u.toJson()).toList(),
        'organisationUnits': orgUnits.map((ou) => ou.toJson()).toList(),
        // Add more entities as they are converted
      };
    });
  }

  /// Import JSON data to Isar database
  Future<void> importFromJson(Map<String, dynamic> jsonData) async {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    await isarManager.writeTxn((isar) async {
      // Import users
      if (jsonData['users'] != null) {
        final users = (jsonData['users'] as List)
            .map((json) => UserIsar.fromJson(json))
            .toList();
        await isar.userIsars.putAll(users);
      }
      
      // Import organization units
      if (jsonData['organisationUnits'] != null) {
        final orgUnits = (jsonData['organisationUnits'] as List)
            .map((json) => OrganisationUnitIsar.fromJson(json))
            .toList();
        await isar.organisationUnitIsars.putAll(orgUnits);
      }
      
      // Add more entities as they are converted
    });
    
    if (kDebugMode) {
      print('Data imported successfully');
      final stats = await getDatabaseStats();
      print('Database size after import: ${stats['sizeFormatted']}');
    }
  }

  // ========== REACTIVE DATA STREAMS ==========

  /// Watch current user changes
  Stream<UserIsar?> watchCurrentUser() {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    return userIsarQuery.watchLoggedInUser();
  }

  /// Watch organization units changes
  Stream<List<OrganisationUnitIsar>> watchOrganisationUnits() {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    return organisationUnitIsarQuery.watch();
  }

  // ========== LIFECYCLE MANAGEMENT ==========

  /// Dispose of resources
  Future<void> dispose() async {
    if (useIsar && _isarManager != null) {
      await _isarManager!.dispose();
      _isarManager = null;
    }
    
    _d2Instance = null;
    
    if (kDebugMode) {
      print('D2TouchIsar disposed');
    }
  }

  /// Delete all data and reset database
  Future<void> reset() async {
    if (!useIsar) {
      throw StateError('Isar not enabled.');
    }
    
    await _isarManager!.deleteDatabase();
    
    // Reinitialize
    final databaseName = await DatabaseUtil.getDatabaseName() ?? 'dhis2_database';
    await _initializeIsar(
      databaseName: databaseName,
      inMemory: inMemory ?? false,
    );
    
    if (kDebugMode) {
      print('Database reset successfully');
    }
  }

  // ========== STATIC UTILITIES ==========

  /// Get current instance
  static D2TouchIsar? get instance => _d2Instance;

  /// Check if Isar is enabled in current instance
  static bool get isIsarEnabled => _d2Instance?.useIsar ?? false;

  /// Get database type string
  String get databaseType => useIsar ? 'Isar' : 'SQLite';

  /// Get database info
  Map<String, dynamic> get info => {
    'databaseType': databaseType,
    'instanceVersion': instanceVersion,
    'locale': locale,
    'useIsar': useIsar,
    'inMemory': inMemory,
  };

  @override
  String toString() {
    return 'D2TouchIsar(databaseType: $databaseType, useIsar: $useIsar, locale: $locale)';
  }
}

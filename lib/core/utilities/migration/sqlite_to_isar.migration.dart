import 'dart:io';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_isar.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/program_isar.entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

/// SQLite to Isar Migration Utility
/// 
/// Handles the migration of data from the existing SQLite database
/// to the new Isar database structure for DHIS2 Flutter SDK
class SQLiteToIsarMigration {
  final IsarManager isarManager;
  final String sqliteDatabasePath;
  
  Database? _sqliteDb;
  
  SQLiteToIsarMigration({
    required this.isarManager,
    required this.sqliteDatabasePath,
  });

  /// Perform complete migration from SQLite to Isar
  Future<void> migrate({
    Function(String message, double progress)? onProgress,
    bool validateData = true,
  }) async {
    try {
      onProgress?.call('Initializing migration...', 0.0);
      
      // Open SQLite database
      await _openSQLiteDatabase();
      
      // Get migration statistics
      final stats = await _getMigrationStats();
      if (kDebugMode) {
        print('Migration stats: $stats');
      }
      
      // Perform migrations by entity type
      await _migrateUsers(onProgress, stats);
      await _migrateOrganisationUnits(onProgress, stats);
      await _migratePrograms(onProgress, stats);
      await _migrateTrackedEntities(onProgress, stats);
      await _migrateEnrollments(onProgress, stats);
      await _migrateEvents(onProgress, stats);
      
      // Validate data if requested
      if (validateData) {
        onProgress?.call('Validating migrated data...', 0.9);
        await _validateMigration();
      }
      
      onProgress?.call('Migration completed successfully!', 1.0);
      
    } catch (e) {
      throw MigrationException('Migration failed: $e');
    } finally {
      await _closeSQLiteDatabase();
    }
  }

  /// Open SQLite database for reading
  Future<void> _openSQLiteDatabase() async {
    if (!File(sqliteDatabasePath).existsSync()) {
      throw MigrationException('SQLite database not found at: $sqliteDatabasePath');
    }
    
    _sqliteDb = await openDatabase(
      sqliteDatabasePath,
      version: 1,
      readOnly: true,
    );
  }

  /// Close SQLite database connection
  Future<void> _closeSQLiteDatabase() async {
    await _sqliteDb?.close();
    _sqliteDb = null;
  }

  /// Get migration statistics
  Future<Map<String, int>> _getMigrationStats() async {
    final stats = <String, int>{};
    
    try {
      // Count records in each table
      stats['users'] = await _countRecords('User') ?? 0;
      stats['organisationUnits'] = await _countRecords('OrganisationUnit') ?? 0;
      stats['programs'] = await _countRecords('Program') ?? 0;
      stats['trackedEntityInstances'] = await _countRecords('TrackedEntityInstance') ?? 0;
      stats['enrollments'] = await _countRecords('Enrollment') ?? 0;
      stats['events'] = await _countRecords('Event') ?? 0;
      
    } catch (e) {
      if (kDebugMode) {
        print('Error getting migration stats: $e');
      }
      // Set default values if tables don't exist
      stats.updateAll((key, value) => 0);
    }
    
    return stats;
  }

  /// Count records in SQLite table
  Future<int?> _countRecords(String tableName) async {
    if (_sqliteDb == null) return 0;
    
    try {
      final result = await _sqliteDb!.rawQuery('SELECT COUNT(*) as count FROM $tableName');
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      if (kDebugMode) {
        print('Table $tableName not found or error counting: $e');
      }
      return null;
    }
  }

  /// Migrate users from SQLite to Isar
  Future<void> _migrateUsers(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['users']! == 0) return;
    
    onProgress?.call('Migrating users...', 0.1);
    
    try {
      final List<Map<String, dynamic>> sqliteUsers = await _sqliteDb!.query('User');
      final List<UserIsar> isarUsers = [];
      
      for (final userData in sqliteUsers) {
        try {
          final user = UserIsar.fromJson(userData);
          isarUsers.add(user);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting user ${userData['id']}: $e');
          }
        }
      }
      
      // Save to Isar
      await isarManager.writeTxn((isar) async {
        await isar.userIsars.putAll(isarUsers);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarUsers.length} users');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate users: $e');
    }
  }

  /// Migrate organisation units from SQLite to Isar
  Future<void> _migrateOrganisationUnits(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['organisationUnits']! == 0) return;
    
    onProgress?.call('Migrating organisation units...', 0.2);
    
    try {
      final List<Map<String, dynamic>> sqliteOrgUnits = await _sqliteDb!.query('OrganisationUnit');
      final List<OrganisationUnitIsar> isarOrgUnits = [];
      
      for (final orgUnitData in sqliteOrgUnits) {
        try {
          final orgUnit = OrganisationUnitIsar.fromJson(orgUnitData);
          isarOrgUnits.add(orgUnit);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting organisation unit ${orgUnitData['id']}: $e');
          }
        }
      }
      
      // Save to Isar
      await isarManager.writeTxn((isar) async {
        await isar.organisationUnitIsars.putAll(isarOrgUnits);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarOrgUnits.length} organisation units');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate organisation units: $e');
    }
  }

  /// Migrate programs from SQLite to Isar
  Future<void> _migratePrograms(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['programs']! == 0) return;
    
    onProgress?.call('Migrating programs...', 0.3);
    
    try {
      final List<Map<String, dynamic>> sqlitePrograms = await _sqliteDb!.query('Program');
      final List<ProgramIsar> isarPrograms = [];
      
      for (final programData in sqlitePrograms) {
        try {
          final program = ProgramIsar.fromJson(programData);
          isarPrograms.add(program);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting program ${programData['id']}: $e');
          }
        }
      }
      
      // Save to Isar
      await isarManager.writeTxn((isar) async {
        await isar.programIsars.putAll(isarPrograms);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarPrograms.length} programs');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate programs: $e');
    }
  }

  /// Migrate tracked entities from SQLite to Isar
  Future<void> _migrateTrackedEntities(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['trackedEntityInstances']! == 0) return;
    
    onProgress?.call('Migrating tracked entities...', 0.5);
    
    try {
      final List<Map<String, dynamic>> sqliteTEIs = await _sqliteDb!.query('TrackedEntityInstance');
      final List<TrackedEntityIsar> isarTEIs = [];
      
      for (final teiData in sqliteTEIs) {
        try {
          final tei = TrackedEntityIsar.fromJson(teiData);
          isarTEIs.add(tei);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting tracked entity ${teiData['id']}: $e');
          }
        }
      }
      
      // Save to Isar in batches for better performance
      await _saveBatch(isarTEIs, (isar, batch) async {
        await isar.trackedEntityIsars.putAll(batch);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarTEIs.length} tracked entities');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate tracked entities: $e');
    }
  }

  /// Migrate enrollments from SQLite to Isar
  Future<void> _migrateEnrollments(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['enrollments']! == 0) return;
    
    onProgress?.call('Migrating enrollments...', 0.7);
    
    try {
      final List<Map<String, dynamic>> sqliteEnrollments = await _sqliteDb!.query('Enrollment');
      final List<EnrollmentIsar> isarEnrollments = [];
      
      for (final enrollmentData in sqliteEnrollments) {
        try {
          final enrollment = EnrollmentIsar.fromJson(enrollmentData);
          isarEnrollments.add(enrollment);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting enrollment ${enrollmentData['id']}: $e');
          }
        }
      }
      
      // Save to Isar in batches
      await _saveBatch(isarEnrollments, (isar, batch) async {
        await isar.enrollmentIsars.putAll(batch);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarEnrollments.length} enrollments');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate enrollments: $e');
    }
  }

  /// Migrate events from SQLite to Isar
  Future<void> _migrateEvents(
    Function(String, double)? onProgress,
    Map<String, int> stats,
  ) async {
    if (stats['events']! == 0) return;
    
    onProgress?.call('Migrating events...', 0.8);
    
    try {
      final List<Map<String, dynamic>> sqliteEvents = await _sqliteDb!.query('Event');
      final List<EventIsar> isarEvents = [];
      
      for (final eventData in sqliteEvents) {
        try {
          final event = EventIsar.fromJson(eventData);
          isarEvents.add(event);
        } catch (e) {
          if (kDebugMode) {
            print('Error converting event ${eventData['id']}: $e');
          }
        }
      }
      
      // Save to Isar in batches
      await _saveBatch(isarEvents, (isar, batch) async {
        await isar.eventIsars.putAll(batch);
      });
      
      if (kDebugMode) {
        print('Migrated ${isarEvents.length} events');
      }
    } catch (e) {
      throw MigrationException('Failed to migrate events: $e');
    }
  }

  /// Save entities in batches for better performance
  Future<void> _saveBatch<T>(
    List<T> entities,
    Future<void> Function(dynamic isar, List<T> batch) saveFn,
  ) async {
    const batchSize = 1000;
    
    for (int i = 0; i < entities.length; i += batchSize) {
      final end = (i + batchSize < entities.length) ? i + batchSize : entities.length;
      final batch = entities.sublist(i, end);
      
      await isarManager.writeTxn((isar) async {
        await saveFn(isar, batch);
      });
    }
  }

  /// Validate the migration by comparing record counts
  Future<void> _validateMigration() async {
    final sqliteStats = await _getMigrationStats();
    final isarStats = await _getIsarStats();
    
    final discrepancies = <String>[];
    
    for (final entry in sqliteStats.entries) {
      final sqliteCount = entry.value;
      final isarCount = isarStats[entry.key] ?? 0;
      
      if (sqliteCount != isarCount) {
        discrepancies.add('${entry.key}: SQLite=$sqliteCount, Isar=$isarCount');
      }
    }
    
    if (discrepancies.isNotEmpty) {
      throw MigrationException('Migration validation failed. Discrepancies: ${discrepancies.join(', ')}');
    }
    
    if (kDebugMode) {
      print('Migration validation successful!');
      print('SQLite stats: $sqliteStats');
      print('Isar stats: $isarStats');
    }
  }

  /// Get statistics from Isar database
  Future<Map<String, int>> _getIsarStats() async {
    return await isarManager.readTxn((isar) async {
      return {
        'users': await isar.userIsars.count(),
        'organisationUnits': await isar.organisationUnitIsars.count(),
        'programs': await isar.programIsars.count(),
        'trackedEntityInstances': await isar.trackedEntityIsars.count(),
        'enrollments': await isar.enrollmentIsars.count(),
        'events': await isar.eventIsars.count(),
      };
    });
  }

  /// Backup SQLite database before migration
  Future<String> backupSQLiteDatabase() async {
    final sourceFile = File(sqliteDatabasePath);
    if (!sourceFile.existsSync()) {
      throw MigrationException('SQLite database not found for backup');
    }
    
    final backupPath = '${sqliteDatabasePath}.backup.${DateTime.now().millisecondsSinceEpoch}';
    await sourceFile.copy(backupPath);
    
    if (kDebugMode) {
      print('SQLite database backed up to: $backupPath');
    }
    
    return backupPath;
  }

  /// Restore SQLite database from backup
  Future<void> restoreSQLiteDatabase(String backupPath) async {
    final backupFile = File(backupPath);
    if (!backupFile.existsSync()) {
      throw MigrationException('Backup file not found: $backupPath');
    }
    
    await backupFile.copy(sqliteDatabasePath);
    
    if (kDebugMode) {
      print('SQLite database restored from: $backupPath');
    }
  }

  /// Check if migration is needed
  Future<bool> isMigrationNeeded() async {
    try {
      // Check if SQLite database exists and has data
      if (!File(sqliteDatabasePath).existsSync()) {
        return false;
      }
      
      await _openSQLiteDatabase();
      final sqliteStats = await _getMigrationStats();
      await _closeSQLiteDatabase();
      
      // Check if Isar database is empty
      final isarStats = await _getIsarStats();
      
      // Migration is needed if SQLite has data but Isar doesn't
      final sqliteHasData = sqliteStats.values.any((count) => count > 0);
      final isarHasData = isarStats.values.any((count) => count > 0);
      
      return sqliteHasData && !isarHasData;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking migration need: $e');
      }
      return false;
    }
  }

  /// Get migration progress information
  Future<Map<String, dynamic>> getMigrationInfo() async {
    try {
      await _openSQLiteDatabase();
      final sqliteStats = await _getMigrationStats();
      await _closeSQLiteDatabase();
      
      final isarStats = await _getIsarStats();
      final needsMigration = await isMigrationNeeded();
      
      return {
        'needsMigration': needsMigration,
        'sqliteStats': sqliteStats,
        'isarStats': isarStats,
        'totalSQLiteRecords': sqliteStats.values.fold<int>(0, (sum, count) => sum + count),
        'totalIsarRecords': isarStats.values.fold<int>(0, (sum, count) => sum + count),
      };
    } catch (e) {
      return {
        'needsMigration': false,
        'error': e.toString(),
      };
    }
  }
}

/// Exception thrown during migration operations
class MigrationException implements Exception {
  final String message;
  
  const MigrationException(this.message);
  
  @override
  String toString() => 'MigrationException: $message';
}

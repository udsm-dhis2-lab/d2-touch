import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

/// Isar Database Manager
/// 
/// Replaces the SQLite-based DatabaseManager with Isar implementation
/// Provides better performance, type safety, and mobile optimization
/// for the DHIS2 Flutter SDK
class IsarManager {
  static IsarManager? _instance;
  static Isar? _isar;
  
  final String databaseName;
  final List<CollectionSchema<dynamic>> schemas;
  final bool inMemory;

  IsarManager._internal({
    required this.databaseName,
    required this.schemas,
    this.inMemory = false,
  });

  /// Factory constructor for IsarManager
  /// 
  /// Example:
  /// ```dart
  /// final manager = IsarManager(
  ///   databaseName: 'dhis2_database',
  ///   schemas: [UserSchema, OrganisationUnitSchema],
  /// );
  /// ```
  factory IsarManager({
    required String databaseName,
    required List<CollectionSchema<dynamic>> schemas,
    bool inMemory = false,
  }) {
    _instance ??= IsarManager._internal(
      databaseName: databaseName,
      schemas: schemas,
      inMemory: inMemory,
    );
    return _instance!;
  }

  /// Get the singleton instance
  static IsarManager? get instance => _instance;

  /// Get the Isar database instance
  Future<Isar> get database async {
    if (_isar != null && _isar!.isOpen) {
      return _isar!;
    }
    return await _initializeDatabase();
  }

  /// Initialize the Isar database
  Future<Isar> _initializeDatabase() async {
    try {
      late String databasePath;
      
      if (inMemory) {
        // Use in-memory database for testing
        databasePath = '';
      } else {
        // Get the application documents directory
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        databasePath = join(appDocDir.path, 'isar_databases');
        
        // Create the directory if it doesn't exist
        await Directory(databasePath).create(recursive: true);
      }

      // Open Isar database with optimized settings for DHIS2
      _isar = await Isar.open(
        schemas,
        directory: databasePath,
        name: databaseName,
        maxSizeMiB: inMemory ? null : 512, // 512MB max for mobile devices
        compactOnLaunch: CompactCondition.auto,
        inspector: false, // Disable in production for performance
      );

      return _isar!;
    } catch (e) {
      throw IsarDatabaseException('Failed to initialize Isar database: $e');
    }
  }

  /// Perform a read transaction
  /// 
  /// Example:
  /// ```dart
  /// final users = await manager.readTxn((isar) async {
  ///   return await isar.users.where().findAll();
  /// });
  /// ```
  Future<T> readTxn<T>(Future<T> Function(Isar isar) callback) async {
    final isar = await database;
    return await isar.txn(() => callback(isar));
  }

  /// Perform a write transaction
  /// 
  /// Example:
  /// ```dart
  /// await manager.writeTxn((isar) async {
  ///   await isar.users.put(user);
  /// });
  /// ```
  Future<T> writeTxn<T>(Future<T> Function(Isar isar) callback) async {
    final isar = await database;
    return await isar.writeTxn(() => callback(isar));
  }

  /// Get database size in bytes
  Future<int> getDatabaseSize() async {
    final isar = await database;
    return await isar.getSize();
  }

  /// Compact the database to optimize storage
  /// Useful for mobile devices with limited storage
  Future<void> compact() async {
    final isar = await database;
    await isar.writeTxn(() => isar.compact());
  }

  /// Check if database is encrypted (for future implementation)
  Future<bool> isEncrypted() async {
    // TODO: Implement encryption check when Isar supports it
    return false;
  }

  /// Close the database connection
  Future<void> close() async {
    if (_isar != null && _isar!.isOpen) {
      await _isar!.close();
      _isar = null;
    }
  }

  /// Dispose of the database manager
  /// Closes connections and cleans up resources
  Future<void> dispose() async {
    await close();
    _instance = null;
  }

  /// Delete the entire database
  /// Useful for logout operations or data reset
  Future<void> deleteDatabase() async {
    await close();
    
    if (!inMemory) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final databasePath = join(appDocDir.path, 'isar_databases');
      final dbFile = File(join(databasePath, '$databaseName.isar'));
      
      if (await dbFile.exists()) {
        await dbFile.delete();
      }
    }
  }

  /// Get database statistics for monitoring
  Future<Map<String, dynamic>> getStats() async {
    final isar = await database;
    final size = await isar.getSize();
    
    return {
      'databaseName': databaseName,
      'size': size,
      'sizeFormatted': '${(size / (1024 * 1024)).toStringAsFixed(2)} MB',
      'isOpen': isar.isOpen,
      'schemaCount': schemas.length,
    };
  }
}

/// Custom exception for Isar database operations
class IsarDatabaseException implements Exception {
  final String message;
  
  const IsarDatabaseException(this.message);
  
  @override
  String toString() => 'IsarDatabaseException: $message';
}

/// Helper class for common database operations
class IsarHelper {
  /// Generate a unique ID for DHIS2 entities
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString() + 
           (1000 + DateTime.now().microsecond % 9000).toString();
  }

  /// Convert DateTime to milliseconds since epoch for Isar storage
  static int dateTimeToMillis(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// Convert milliseconds since epoch back to DateTime
  static DateTime millisToDateTime(int millis) {
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  /// Check if a string is a valid DHIS2 UID
  static bool isValidDhis2Uid(String? uid) {
    if (uid == null || uid.isEmpty) return false;
    // DHIS2 UIDs are 11 characters: letter followed by 10 alphanumeric
    final regex = RegExp(r'^[a-zA-Z][a-zA-Z0-9]{10}$');
    return regex.hasMatch(uid);
  }
}

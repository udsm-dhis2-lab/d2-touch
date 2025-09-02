import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit_isar.entity.dart';
import 'isar_service.dart';
import '../models/app_state.dart';

class DHIS2Service {
  static String? _baseUrl;
  static String? _authHeader;

  // DHIS2 Lab instance - you can change this to your DHIS2 instance
  static const String defaultBaseUrl = 'https://play.im.dhis2.org/stable-2-42-1';
  static const String defaultUsername = 'admin';
  static const String defaultPassword = 'district';

  static Future<bool> login(String baseUrl, String username, String password) async {
    try {
      _baseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      _authHeader = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      // Test authentication by fetching current user
      final response = await http.get(
        Uri.parse('$_baseUrl/api/me'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        
        // Create and save user
        final user = UserIsar.fromApi(userData);
        user.baseUrl = _baseUrl!;
        user.isLoggedIn = true;
        user.token = _authHeader;
        
        await IsarService.saveUser(user);
        
        return true;
      } else {
        throw Exception('Authentication failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  static Future<bool> isAuthenticated() async {
    final user = await IsarService.getCurrentUser();
    return user != null && user.isLoggedIn;
  }

  static Future<void> logout() async {
    await IsarService.logoutUser();
    _baseUrl = null;
    _authHeader = null;
  }

  static Future<UserIsar?> getCurrentUser() async {
    return await IsarService.getCurrentUser();
  }

  static Future<void> syncMetadata({
    required Function(SyncStatus) onStatusUpdate,
  }) async {
    try {
      final user = await getCurrentUser();
      if (user == null || !user.isLoggedIn) {
        throw Exception('User not authenticated');
      }

      _baseUrl = user.baseUrl;
      _authHeader = user.token;

      onStatusUpdate(SyncStatus.inProgress('Starting metadata sync...', 0.1));

      // Sync organisation units
      await _syncOrganisationUnits(onStatusUpdate);

      onStatusUpdate(SyncStatus.completed('Metadata sync completed successfully!'));
      
      // Mark all data as synced
      await IsarService.markAllAsSynced();
      
    } catch (e) {
      onStatusUpdate(SyncStatus.error('Sync failed', e.toString()));
      rethrow;
    }
  }

  static Future<void> _syncOrganisationUnits(Function(SyncStatus) onStatusUpdate) async {
    try {
      onStatusUpdate(SyncStatus.inProgress('Syncing organisation units...', 0.3));

      final response = await http.get(
        Uri.parse('$_baseUrl/api/organisationUnits?fields=id,name,displayName,level,path,parent[id],geometry,openingDate,coordinates&paging=false'),
        headers: {
          'Authorization': _authHeader!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final orgUnitsData = data['organisationUnits'] as List;

        onStatusUpdate(SyncStatus.inProgress('Processing ${orgUnitsData.length} organisation units...', 0.6));

        final orgUnits = <OrganisationUnitIsar>[];
        
        for (int i = 0; i < orgUnitsData.length; i++) {
          final orgUnitData = orgUnitsData[i];
          final orgUnit = OrganisationUnitIsar.fromApi(orgUnitData);
          orgUnits.add(orgUnit);
          
          // Update progress
          if (i % 50 == 0) {
            final progress = 0.6 + (i / orgUnitsData.length) * 0.3;
            onStatusUpdate(SyncStatus.inProgress('Processing organisation units: ${i + 1}/${orgUnitsData.length}', progress));
          }
        }

        // Save all organisation units
        await IsarService.saveOrganisationUnits(orgUnits);
        
        onStatusUpdate(SyncStatus.inProgress('Organisation units sync completed', 0.9));
        
      } else {
        throw Exception('Failed to fetch organisation units: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Organisation units sync failed: $e');
    }
  }

  static Future<Map<String, dynamic>> getSystemInfo() async {
    try {
      final user = await getCurrentUser();
      if (user == null || !user.isLoggedIn) {
        throw Exception('User not authenticated');
      }

      final response = await http.get(
        Uri.parse('${user.baseUrl}/api/system/info'),
        headers: {
          'Authorization': user.token!,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch system info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('System info fetch failed: $e');
    }
  }

  // Helper method to get default credentials for testing
  static Map<String, String> getDefaultCredentials() {
    return {
      'baseUrl': defaultBaseUrl,
      'username': defaultUsername,
      'password': defaultPassword,
    };
  }

  static Future<List<Map<String, dynamic>>> getOrganisationUnitHierarchy() async {
    final orgUnits = await IsarService.getAllOrganisationUnits();
    
    // Group by level for display
    final hierarchy = <String, List<OrganisationUnitIsar>>{};
    
    for (final orgUnit in orgUnits) {
      final levelKey = 'Level ${orgUnit.level ?? 0}';
      hierarchy[levelKey] ??= [];
      hierarchy[levelKey]!.add(orgUnit);
    }
    
    return hierarchy.entries.map((entry) => {
      'level': entry.key,
      'count': entry.value.length,
      'units': entry.value.map((ou) => {
        'id': ou.dhis2Id,
        'name': ou.name,
        'hasCoordinates': ou.hasCoordinates,
      }).toList(),
    }).toList();
  }
}

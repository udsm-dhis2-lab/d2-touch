import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:d2_touch/core/database/isar_manager.dart';
import 'package:d2_touch/core/utilities/isar_repository.dart';
import 'package:d2_touch/modules/auth/entities/user_isar.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:d2_touch/shared/utilities/save_option.util.dart';

/// UserIsar Query Class
/// 
/// Specialized query class for UserIsar entity with authentication-specific operations
/// Provides user authentication, profile management, and organization unit filtering
class UserIsarQuery {
  final IsarManager isarManager;
  final IsarRepository<UserIsar> repository;
  
  // Query parameters
  List<String>? userGroupsId;
  bool userOrgUnits = false;
  bool includeChildren = false;
  String? filterMode;
  
  // Query state
  dynamic data;
  List<String> selected = const [];
  MergeMode _mergeMode = MergeMode.Replace;

  UserIsarQuery({
    required this.isarManager,
    this.userGroupsId,
    this.filterMode,
    this.includeChildren = false,
    this.userOrgUnits = false,
  }) : repository = IsarRepository<UserIsar>(
          isarManager: isarManager,
          collection: isarManager.database.then((isar) => isar.userIsars),
        );

  /// Set merge mode for save operations
  set mergeMode(MergeMode mergeMode) {
    _mergeMode = mergeMode;
  }

  /// Select specific fields for API queries
  UserIsarQuery select(List<String> fields) {
    selected = fields;
    return this;
  }

  /// Filter by user ID
  UserIsarQuery byId(String userId) {
    return this;
  }

  /// Filter by username
  Future<UserIsarQuery> byUsername(String username) async {
    // This will be implemented with the actual filtering logic
    return this;
  }

  /// Filter by login status
  Future<UserIsarQuery> byLoginStatus(bool isLoggedIn) async {
    return this;
  }

  /// Filter by base URL (DHIS2 instance)
  Future<UserIsarQuery> byBaseUrl(String baseUrl) async {
    return this;
  }

  /// Filter by authority
  Future<UserIsarQuery> hasAuthority(String authority) async {
    return this;
  }

  /// Filter by organization unit
  Future<UserIsarQuery> belongsToOrgUnit(String orgUnitId) async {
    return this;
  }

  /// Filter by user groups
  UserIsarQuery byGroups({
    required List<String> userGroupsId, 
    required String filterMode
  }) {
    this.filterMode = filterMode;
    this.userGroupsId = userGroupsId;
    return this;
  }

  /// Filter by user organization units
  UserIsarQuery byUserOrgUnits() {
    userOrgUnits = true;
    includeChildren = true;
    return this;
  }

  /// Set data for save operations
  UserIsarQuery setData(dynamic data) {
    this.data = data;
    return this;
  }

  /// Get all matching users
  Future<List<UserIsar>> get({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      return await fetchOnline(dioTestClient: dioTestClient);
    }

    return await isarManager.readTxn((isar) async {
      return await isar.userIsars.where().findAll();
    });
  }

  /// Get single user
  Future<UserIsar?> getOne({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      final results = await fetchOnline(dioTestClient: dioTestClient);
      return results.isNotEmpty ? results.first : null;
    }

    final results = await get();
    return results.isNotEmpty ? results.first : null;
  }

  /// Get currently logged in user
  Future<UserIsar?> getLoggedInUser() async {
    return await isarManager.readTxn((isar) async {
      return await isar.userIsars
          .filter()
          .isLoggedInEqualTo(true)
          .findFirst();
    });
  }

  /// Get user by username and base URL
  Future<UserIsar?> getUserByCredentials(String username, String baseUrl) async {
    return await isarManager.readTxn((isar) async {
      return await isar.userIsars
          .filter()
          .usernameEqualTo(username)
          .and()
          .baseUrlEqualTo(baseUrl)
          .findFirst();
    });
  }

  /// Get users with expired tokens
  Future<List<UserIsar>> getUsersWithExpiredTokens() async {
    return await isarManager.readTxn((isar) async {
      final now = DateTime.now().millisecondsSinceEpoch;
      return await isar.userIsars
          .filter()
          .tokenExpiresAtTimestampIsNotNull()
          .and()
          .tokenExpiresAtTimestampLessThan(now)
          .findAll();
    });
  }

  /// Get users by authority
  Future<List<UserIsar>> getUsersByAuthority(String authority) async {
    return await isarManager.readTxn((isar) async {
      final users = await isar.userIsars.where().findAll();
      return users.where((user) => user.hasAuthority(authority)).toList();
    });
  }

  /// Watch users (reactive stream)
  Stream<List<UserIsar>> watch({bool fireImmediately = true}) {
    final isar = isarManager.database;
    return isar.asStream().asyncMap((db) => 
      db.userIsars.where().watch(fireImmediately: fireImmediately)
    ).asyncExpand((stream) => stream);
  }

  /// Watch logged in user
  Stream<UserIsar?> watchLoggedInUser({bool fireImmediately = true}) {
    final isar = isarManager.database;
    return isar.asStream().asyncMap((db) => 
      db.userIsars
          .filter()
          .isLoggedInEqualTo(true)
          .watch(fireImmediately: fireImmediately)
          .map((users) => users.isNotEmpty ? users.first : null)
    ).asyncExpand((stream) => stream);
  }

  /// Save user data
  Future<int> save({SaveOptions? saveOptions}) async {
    if (data is List) {
      return await repository.saveMany(
        entities: data as List<UserIsar>,
        mergeMode: _mergeMode,
        saveOptions: saveOptions,
      );
    }
    
    if (data != null) {
      final user = data as UserIsar;
      user.updateTimestamp();
      
      await repository.saveOne(
        entity: user,
        mergeMode: _mergeMode,
        saveOptions: saveOptions,
      );
      return 1;
    }
    
    return 0;
  }

  /// Login user (mark as logged in and save)
  Future<UserIsar> loginUser(UserIsar user) async {
    // Logout any currently logged in users first
    await logoutAllUsers();
    
    // Mark this user as logged in
    user.isLoggedIn = true;
    user.markDirty();
    
    await repository.saveOne(entity: user);
    return user;
  }

  /// Logout specific user
  Future<void> logoutUser(String userId) async {
    return await isarManager.writeTxn((isar) async {
      final user = await isar.userIsars
          .filter()
          .dhis2IdEqualTo(userId)
          .findFirst();
          
      if (user != null) {
        user.isLoggedIn = false;
        user.markDirty();
        await isar.userIsars.put(user);
      }
    });
  }

  /// Logout all users
  Future<void> logoutAllUsers() async {
    return await isarManager.writeTxn((isar) async {
      final loggedInUsers = await isar.userIsars
          .filter()
          .isLoggedInEqualTo(true)
          .findAll();
      
      for (final user in loggedInUsers) {
        user.isLoggedIn = false;
        user.markDirty();
      }
      
      if (loggedInUsers.isNotEmpty) {
        await isar.userIsars.putAll(loggedInUsers);
      }
    });
  }

  /// Update user token
  Future<void> updateToken(String userId, {
    String? token,
    String? tokenType,
    String? refreshToken,
    DateTime? expiresAt,
  }) async {
    return await isarManager.writeTxn((isar) async {
      final user = await isar.userIsars
          .filter()
          .dhis2IdEqualTo(userId)
          .findFirst();
          
      if (user != null) {
        if (token != null) user.token = token;
        if (tokenType != null) user.tokenType = tokenType;
        if (refreshToken != null) user.refreshToken = refreshToken;
        if (expiresAt != null) user.tokenExpiresAt = expiresAt;
        
        user.markDirty();
        await isar.userIsars.put(user);
      }
    });
  }

  /// Count users
  Future<int> count() async {
    return await repository.count();
  }

  /// Delete user
  Future<bool> delete(String userId) async {
    return await repository.deleteById(userId);
  }

  /// Delete all users
  Future<int> deleteAll() async {
    return await repository.deleteAll();
  }

  /// Fetch users from DHIS2 API
  Future<List<UserIsar>> fetchOnline({Dio? dioTestClient}) async {
    try {
      final url = await dhisUrl();
      final response = await HttpClient.get(
        url,
        database: null, // Not needed for Isar
        dioTestClient: dioTestClient,
      );

      List data = response.body != null && response.body['users'] != null
          ? response.body['users']?.toList() ?? []
          : [];

      return data.map((userJson) {
        userJson['dirty'] = false;
        userJson['synced'] = true;
        return UserIsar.fromApi(userJson);
      }).toList();
    } catch (e) {
      print('Error fetching users online: $e');
      return [];
    }
  }

  /// Download users from API and save to database
  Future<List<UserIsar>?> download(
    Function(RequestProgress, bool) callback, {
    Dio? dioTestClient,
  }) async {
    callback(
      RequestProgress(
        resourceName: 'users',
        message: 'Downloading users from the server....',
        status: '',
        percentage: 0,
      ),
      false,
    );

    final users = await fetchOnline(dioTestClient: dioTestClient);

    if (users.isEmpty) {
      callback(
        RequestProgress(
          resourceName: 'users',
          message: 'No users found.',
          status: '',
          percentage: 100,
        ),
        true,
      );
      return [];
    }

    callback(
      RequestProgress(
        resourceName: 'users',
        message: '${users.length} users downloaded successfully',
        status: '',
        percentage: 50,
      ),
      false,
    );

    callback(
      RequestProgress(
        resourceName: 'users',
        message: 'Saving ${users.length} users into database...',
        status: '',
        percentage: 51,
      ),
      false,
    );

    data = users;
    await save();

    callback(
      RequestProgress(
        resourceName: 'users',
        message: '${users.length} users successfully saved',
        status: '',
        percentage: 100,
      ),
      true,
    );

    return users;
  }

  /// Generate DHIS2 API URL for user queries
  Future<String> dhisUrl() async {
    final baseFields = [
      'id', 'name', 'firstName', 'surname', 'username', 'phoneNumber',
      'created', 'lastUpdated', 'birthday', 'gender', 'displayName',
      'jobTitle', 'employer', 'email', 'nationality',
      'userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]]',
      'organisationUnits[id,code,name]',
      'dataViewOrganisationUnits[id,code,name]',
      'userGroups[id,name]',
      'authorities',
      'programs',
      'dataSets'
    ];

    final fields = selected.isNotEmpty ? selected : baseFields;
    String apiFilter = '';

    if (userGroupsId != null && filterMode != null) {
      apiFilter = 'filter=userGroups.$filterMode:in:${userGroupsId!.join(',')}';
    }

    final queryParams = [
      if (apiFilter.isNotEmpty) apiFilter,
      'fields=${fields.join(',')}',
      'userOrgUnits=$userOrgUnits',
      'includeChildren=$includeChildren',
      'paging=false'
    ];

    return 'users.json?${queryParams.join('&')}';
  }

  /// Create table (compatibility method)
  Future<void> createTable() async {
    await repository.create();
  }
}

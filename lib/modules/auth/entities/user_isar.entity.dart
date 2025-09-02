import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

part 'user_isar.entity.g.dart';

/// User Isar Collection
/// 
/// Replaces the SQLite-based User entity with Isar collection
/// Handles DHIS2 user authentication and profile information
@collection
class UserIsar extends IdentifiableIsarEntity {
  /// Username for login
  @Index()
  String? username;

  /// Password (should be handled securely)
  String? password;

  /// First name
  late String firstName;

  /// Surname/Last name
  String? surname;

  /// Phone number
  String? phoneNumber;

  /// Authentication token
  String? token;

  /// Token type (e.g., 'Bearer')
  String? tokenType;

  /// Refresh token for token renewal
  String? refreshToken;

  /// Token expiry timestamp
  int? tokenExpiryTimestamp;

  /// Authentication type ('basic', 'token', 'oauth')
  String? authType;

  /// Base URL of the DHIS2 instance
  @Index()
  late String baseUrl;

  /// Organisation units for tracked entity search
  String? teiSearchOrganisationUnits;

  /// Gender
  String? gender;

  /// Job title
  String? jobTitle;

  /// Login status
  @Index()
  late bool isLoggedIn;

  /// Serialized organisation units JSON
  String? organisationUnitsJson;

  /// Serialized authorities JSON
  String? authoritiesJson;

  /// Serialized user roles JSON
  String? rolesJson;

  /// Serialized data view organisation units JSON
  String? dataViewOrganisationUnitsJson;

  /// Serialized programs JSON
  String? programsJson;

  /// Serialized data sets JSON
  String? dataSetsJson;

  /// Serialized user groups JSON
  String? userGroupsJson;

  /// Token expires at timestamp
  int? tokenExpiresAtTimestamp;

  UserIsar() : super() {
    isLoggedIn = false;
    firstName = '';
  }

  /// Get token expiry as DateTime
  DateTime? get tokenExpiryAt {
    if (tokenExpiryTimestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(tokenExpiryTimestamp!);
    }
    return null;
  }

  /// Set token expiry from DateTime
  set tokenExpiryAt(DateTime? dateTime) {
    tokenExpiryTimestamp = dateTime?.millisecondsSinceEpoch;
  }

  /// Get token expires at as DateTime
  DateTime? get tokenExpiresAt {
    if (tokenExpiresAtTimestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(tokenExpiresAtTimestamp!);
    }
    return null;
  }

  /// Set token expires at from DateTime
  set tokenExpiresAt(DateTime? dateTime) {
    tokenExpiresAtTimestamp = dateTime?.millisecondsSinceEpoch;
  }

  /// Check if token is expired
  bool get isTokenExpired {
    if (tokenExpiresAtTimestamp == null) return false;
    return DateTime.now().millisecondsSinceEpoch > tokenExpiresAtTimestamp!;
  }

  /// Get organisation units from JSON
  @ignore
  List<Map<String, dynamic>> get organisationUnits {
    if (organisationUnitsJson == null || organisationUnitsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(organisationUnitsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set organisation units as JSON
  set organisationUnits(List<Map<String, dynamic>> orgUnits) {
    organisationUnitsJson = jsonEncode(orgUnits);
  }

  /// Get authorities from JSON
  @ignore
  List<String> get authorities {
    if (authoritiesJson == null || authoritiesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(authoritiesJson!);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  /// Set authorities as JSON
  set authorities(List<String> auths) {
    authoritiesJson = jsonEncode(auths);
  }

  /// Get user roles from JSON
  @ignore
  List<Map<String, dynamic>> get roles {
    if (rolesJson == null || rolesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(rolesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set user roles as JSON
  set roles(List<Map<String, dynamic>> userRoles) {
    rolesJson = jsonEncode(userRoles);
  }

  /// Get data view organisation units from JSON
  @ignore
  List<Map<String, dynamic>> get dataViewOrganisationUnits {
    if (dataViewOrganisationUnitsJson == null || dataViewOrganisationUnitsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(dataViewOrganisationUnitsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set data view organisation units as JSON
  set dataViewOrganisationUnits(List<Map<String, dynamic>> dataViewOrgUnits) {
    dataViewOrganisationUnitsJson = jsonEncode(dataViewOrgUnits);
  }

  /// Get programs from JSON
  @ignore
  List<Map<String, dynamic>> get programs {
    if (programsJson == null || programsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set programs as JSON
  set programs(List<Map<String, dynamic>> programList) {
    programsJson = jsonEncode(programList);
  }

  /// Get data sets from JSON
  @ignore
  List<Map<String, dynamic>> get dataSets {
    if (dataSetsJson == null || dataSetsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(dataSetsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set data sets as JSON
  set dataSets(List<Map<String, dynamic>> dataSetList) {
    dataSetsJson = jsonEncode(dataSetList);
  }

  /// Get user groups from JSON
  @ignore
  List<Map<String, dynamic>> get userGroups {
    if (userGroupsJson == null || userGroupsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(userGroupsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set user groups as JSON
  set userGroups(List<Map<String, dynamic>> groups) {
    userGroupsJson = jsonEncode(groups);
  }

  /// Get full name
  @ignore
  String get fullName {
    if (surname != null && surname!.isNotEmpty) {
      return '$firstName $surname';
    }
    return firstName;
  }

  /// Check if user has specific authority
  bool hasAuthority(String authority) {
    return authorities.contains(authority);
  }

  /// Check if user belongs to specific organisation unit
  bool belongsToOrganisationUnit(String orgUnitId) {
    return organisationUnits.any((ou) => ou['id'] == orgUnitId);
  }

  /// Factory constructor from JSON (DHIS2 API response)
  factory UserIsar.fromApi(Map<String, dynamic> json) {
    final user = UserIsar();
    
    user.dhis2Id = json['id'] ?? '';
    user.name = json['name'] ?? '';
    user.firstName = json['firstName'] ?? '';
    user.surname = json['surname'];
    user.username = json['username'];
    user.password = json['password'];
    user.phoneNumber = json['phoneNumber'];
    user.baseUrl = json['baseUrl'] ?? '';
    user.gender = json['gender'];
    user.jobTitle = json['jobTitle'];
    user.isLoggedIn = json['isLoggedIn'] ?? false;
    
    // Handle authentication tokens
    user.token = json['token'];
    user.tokenType = json['tokenType'];
    user.refreshToken = json['refreshToken'];
    user.tokenExpiryTimestamp = json['tokenExpiry'];
    user.authType = json['authType'];
    
    // Handle timestamps
    if (json['created'] != null) {
      user.serverCreated = json['created'];
      try {
        user.createdAt = DateTime.parse(json['created']);
      } catch (e) {
        // Keep default timestamp if parsing fails
      }
    }
    
    if (json['lastUpdated'] != null) {
      user.serverLastUpdated = json['lastUpdated'];
      try {
        user.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {
        // Keep default timestamp if parsing fails
      }
    }
    
    // Handle complex objects as JSON strings
    if (json['organisationUnits'] != null) {
      user.organisationUnitsJson = jsonEncode(json['organisationUnits']);
    }
    
    if (json['authorities'] != null) {
      user.authoritiesJson = jsonEncode(json['authorities']);
    }
    
    if (json['roles'] != null) {
      user.rolesJson = jsonEncode(json['roles']);
    }
    
    if (json['dataViewOrganisationUnits'] != null) {
      user.dataViewOrganisationUnitsJson = jsonEncode(json['dataViewOrganisationUnits']);
    }
    
    if (json['programs'] != null) {
      user.programsJson = jsonEncode(json['programs']);
    }
    
    if (json['dataSets'] != null) {
      user.dataSetsJson = jsonEncode(json['dataSets']);
    }
    
    if (json['userGroups'] != null) {
      user.userGroupsJson = jsonEncode(json['userGroups']);
    }
    
    // Handle token expiry
    if (json['tokenExpiresAt'] != null) {
      try {
        user.tokenExpiresAt = DateTime.parse(json['tokenExpiresAt']);
      } catch (e) {
        if (json['tokenExpiry'] != null) {
          user.tokenExpiresAt = DateTime.now().add(Duration(seconds: json['tokenExpiry']));
        }
      }
    }
    
    user.teiSearchOrganisationUnits = json['teiSearchOrganisationUnits']?.toString();
    user.dirty = json['dirty'] ?? false;
    
    return user;
  }

  /// Factory constructor from JSON (local storage)
  factory UserIsar.fromJson(Map<String, dynamic> json) {
    final user = UserIsar();
    
    user.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    user.name = json['name'] ?? '';
    user.firstName = json['firstName'] ?? '';
    user.surname = json['surname'];
    user.username = json['username'];
    user.password = json['password'];
    user.phoneNumber = json['phoneNumber'];
    user.baseUrl = json['baseUrl'] ?? '';
    user.gender = json['gender'];
    user.jobTitle = json['jobTitle'];
    user.isLoggedIn = json['isLoggedIn'] ?? false;
    
    // Authentication tokens
    user.token = json['token'];
    user.tokenType = json['tokenType'];
    user.refreshToken = json['refreshToken'];
    user.authType = json['authType'];
    
    // Timestamps
    user.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    user.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    user.tokenExpiryTimestamp = json['tokenExpiryTimestamp'];
    user.tokenExpiresAtTimestamp = json['tokenExpiresAtTimestamp'];
    
    // JSON strings
    user.organisationUnitsJson = json['organisationUnitsJson'];
    user.authoritiesJson = json['authoritiesJson'];
    user.rolesJson = json['rolesJson'];
    user.dataViewOrganisationUnitsJson = json['dataViewOrganisationUnitsJson'];
    user.programsJson = json['programsJson'];
    user.dataSetsJson = json['dataSetsJson'];
    user.userGroupsJson = json['userGroupsJson'];
    
    user.teiSearchOrganisationUnits = json['teiSearchOrganisationUnits'];
    user.dirty = json['dirty'] ?? false;
    user.synced = json['synced'] ?? false;
    
    return user;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'firstName': firstName,
      'surname': surname,
      'username': username,
      'password': password,
      'phoneNumber': phoneNumber,
      'baseUrl': baseUrl,
      'gender': gender,
      'jobTitle': jobTitle,
      'isLoggedIn': isLoggedIn,
      'token': token,
      'tokenType': tokenType,
      'refreshToken': refreshToken,
      'authType': authType,
      'createdTimestamp': createdTimestamp,
      'lastUpdatedTimestamp': lastUpdatedTimestamp,
      'tokenExpiryTimestamp': tokenExpiryTimestamp,
      'tokenExpiresAtTimestamp': tokenExpiresAtTimestamp,
      'organisationUnitsJson': organisationUnitsJson,
      'authoritiesJson': authoritiesJson,
      'rolesJson': rolesJson,
      'dataViewOrganisationUnitsJson': dataViewOrganisationUnitsJson,
      'programsJson': programsJson,
      'dataSetsJson': dataSetsJson,
      'userGroupsJson': userGroupsJson,
      'teiSearchOrganisationUnits': teiSearchOrganisationUnits,
      'dirty': dirty,
      'synced': synced,
      'serverCreated': serverCreated,
      'serverLastUpdated': serverLastUpdated,
    };
  }

  @override
  String get displayName => fullName;

  @override
  String toString() {
    return 'UserIsar(dhis2Id: $dhis2Id, username: $username, name: $fullName, isLoggedIn: $isLoggedIn)';
  }
}

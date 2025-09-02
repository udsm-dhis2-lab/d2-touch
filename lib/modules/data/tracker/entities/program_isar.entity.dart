import 'dart:convert';
import 'package:isar/isar.dart';
import 'package:d2_touch/shared/entities/base_isar.entity.dart';

/// Program Isar Collection
/// 
/// DHIS2 program for tracker and event management
/// Contains program configurations, stages, and tracked entity types
@collection
class ProgramIsar extends IdentifiableIsarEntity {
  /// Program code
  String? code;

  /// Program version
  int? version;

  /// Short name
  String? shortName;

  /// Program type (WITH_REGISTRATION, WITHOUT_REGISTRATION)
  @Index()
  late String programType;

  /// Program description
  String? description;

  /// Display incident date label
  String? displayIncidentDateLabel;

  /// Display enrollment date label
  String? displayEnrollmentDateLabel;

  /// Incident date label
  String? incidentDateLabel;

  /// Enrollment date label
  String? enrollmentDateLabel;

  /// Select incident dates in future
  bool selectIncidentDatesInFuture = false;

  /// Select enrollment dates in future
  bool selectEnrollmentDatesInFuture = false;

  /// Only enroll once
  bool onlyEnrollOnce = false;

  /// Display front page list
  bool displayFrontPageList = false;

  /// Use first stage on registration page
  bool useFirstStageDuringRegistration = false;

  /// Capture coordinates
  bool captureCoordinates = false;

  /// Feature type (POINT, POLYGON, etc.)
  String? featureType;

  /// Ignore overdue events
  bool ignoreOverdueEvents = false;

  /// Relationship from A
  bool relationshipFromA = false;

  /// Select incident date
  bool selectIncidentDate = false;

  /// Select enrollment date
  bool selectEnrollmentDate = false;

  /// Data entry method
  bool dataEntryMethod = false;

  /// Complete events expiry days
  int? completeEventsExpiryDays;

  /// Expiry days
  int? expiryDays;

  /// Expiry period type
  String? expiryPeriodType;

  /// Min attributes required to search
  int? minAttributesRequiredToSearch;

  /// Max tracked entity instances
  int? maxTeiCountToReturn;

  /// Tracked entity type ID
  @Index()
  String? trackedEntityType;

  /// Category combo ID
  String? categoryCombo;

  /// Access level
  String? accessLevel;

  /// Serialized program stages JSON
  String? programStagesJson;

  /// Serialized program tracked entity attributes JSON
  String? programTrackedEntityAttributesJson;

  /// Serialized program rules JSON
  String? programRulesJson;

  /// Serialized program rule variables JSON
  String? programRuleVariablesJson;

  /// Serialized program attributes JSON
  String? attributesJson;

  /// Serialized organisation units JSON
  String? organisationUnitsJson;

  /// Serialized program indicators JSON
  String? programIndicatorsJson;

  /// Serialized notifications JSON
  String? notificationTemplatesJson;

  ProgramIsar() : super();

  /// Get program stages from JSON
  List<Map<String, dynamic>> get programStages {
    if (programStagesJson == null || programStagesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programStagesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set program stages as JSON
  set programStages(List<Map<String, dynamic>> stages) {
    programStagesJson = jsonEncode(stages);
  }

  /// Get program tracked entity attributes from JSON
  List<Map<String, dynamic>> get programTrackedEntityAttributes {
    if (programTrackedEntityAttributesJson == null || programTrackedEntityAttributesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programTrackedEntityAttributesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set program tracked entity attributes as JSON
  set programTrackedEntityAttributes(List<Map<String, dynamic>> attributes) {
    programTrackedEntityAttributesJson = jsonEncode(attributes);
  }

  /// Get program rules from JSON
  List<Map<String, dynamic>> get programRules {
    if (programRulesJson == null || programRulesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programRulesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set program rules as JSON
  set programRules(List<Map<String, dynamic>> rules) {
    programRulesJson = jsonEncode(rules);
  }

  /// Get program rule variables from JSON
  List<Map<String, dynamic>> get programRuleVariables {
    if (programRuleVariablesJson == null || programRuleVariablesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programRuleVariablesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set program rule variables as JSON
  set programRuleVariables(List<Map<String, dynamic>> variables) {
    programRuleVariablesJson = jsonEncode(variables);
  }

  /// Get attributes from JSON
  List<Map<String, dynamic>> get attributes {
    if (attributesJson == null || attributesJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(attributesJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set attributes as JSON
  set attributes(List<Map<String, dynamic>> attrs) {
    attributesJson = jsonEncode(attrs);
  }

  /// Get organisation units from JSON
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

  /// Get program indicators from JSON
  List<Map<String, dynamic>> get programIndicators {
    if (programIndicatorsJson == null || programIndicatorsJson!.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(programIndicatorsJson!);
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Set program indicators as JSON
  set programIndicators(List<Map<String, dynamic>> indicators) {
    programIndicatorsJson = jsonEncode(indicators);
  }

  /// Check if program is tracker type
  bool get isTracker => programType == 'WITH_REGISTRATION';

  /// Check if program is event type
  bool get isEvent => programType == 'WITHOUT_REGISTRATION';

  /// Get required attributes for search
  List<Map<String, dynamic>> get requiredAttributesForSearch {
    return programTrackedEntityAttributes
        .where((attr) => attr['searchable'] == true)
        .toList();
  }

  /// Get mandatory attributes
  List<Map<String, dynamic>> get mandatoryAttributes {
    return programTrackedEntityAttributes
        .where((attr) => attr['mandatory'] == true)
        .toList();
  }

  /// Get first program stage (registration stage)
  Map<String, dynamic>? get firstProgramStage {
    if (programStages.isEmpty) return null;
    return programStages.first;
  }

  /// Factory constructor from JSON (DHIS2 API)
  factory ProgramIsar.fromApi(Map<String, dynamic> json) {
    final program = ProgramIsar();
    
    program.dhis2Id = json['id'] ?? '';
    program.name = json['name'] ?? json['displayName'] ?? '';
    program.code = json['code'];
    program.version = json['version'];
    program.shortName = json['shortName'];
    program.programType = json['programType'] ?? 'WITH_REGISTRATION';
    program.description = json['description'];
    
    program.displayIncidentDateLabel = json['displayIncidentDateLabel'];
    program.displayEnrollmentDateLabel = json['displayEnrollmentDateLabel'];
    program.incidentDateLabel = json['incidentDateLabel'];
    program.enrollmentDateLabel = json['enrollmentDateLabel'];
    
    program.selectIncidentDatesInFuture = json['selectIncidentDatesInFuture'] ?? false;
    program.selectEnrollmentDatesInFuture = json['selectEnrollmentDatesInFuture'] ?? false;
    program.onlyEnrollOnce = json['onlyEnrollOnce'] ?? false;
    program.displayFrontPageList = json['displayFrontPageList'] ?? false;
    program.useFirstStageDuringRegistration = json['useFirstStageDuringRegistration'] ?? false;
    program.captureCoordinates = json['captureCoordinates'] ?? false;
    program.featureType = json['featureType'];
    program.ignoreOverdueEvents = json['ignoreOverdueEvents'] ?? false;
    program.relationshipFromA = json['relationshipFromA'] ?? false;
    program.selectIncidentDate = json['selectIncidentDatesInFuture'] ?? false;
    program.selectEnrollmentDate = json['selectEnrollmentDatesInFuture'] ?? false;
    program.dataEntryMethod = json['dataEntryMethod'] ?? false;
    
    program.completeEventsExpiryDays = json['completeEventsExpiryDays'];
    program.expiryDays = json['expiryDays'];
    program.expiryPeriodType = json['expiryPeriodType'];
    program.minAttributesRequiredToSearch = json['minAttributesRequiredToSearch'];
    program.maxTeiCountToReturn = json['maxTeiCountToReturn'];
    
    // Handle references
    if (json['trackedEntityType'] != null) {
      if (json['trackedEntityType'] is String) {
        program.trackedEntityType = json['trackedEntityType'];
      } else {
        program.trackedEntityType = json['trackedEntityType']['id'];
      }
    }
    
    if (json['categoryCombo'] != null) {
      if (json['categoryCombo'] is String) {
        program.categoryCombo = json['categoryCombo'];
      } else {
        program.categoryCombo = json['categoryCombo']['id'];
      }
    }
    
    program.accessLevel = json['accessLevel'];
    
    // Handle collections
    if (json['programStages'] != null) {
      program.programStages = (json['programStages'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['programTrackedEntityAttributes'] != null) {
      program.programTrackedEntityAttributes = (json['programTrackedEntityAttributes'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['programRules'] != null) {
      program.programRules = (json['programRules'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['programRuleVariables'] != null) {
      program.programRuleVariables = (json['programRuleVariables'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['attributes'] != null) {
      program.attributes = (json['attributes'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['organisationUnits'] != null) {
      program.organisationUnits = (json['organisationUnits'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['programIndicators'] != null) {
      program.programIndicators = (json['programIndicators'] as List).cast<Map<String, dynamic>>();
    }
    
    if (json['notificationTemplates'] != null) {
      program.notificationTemplatesJson = jsonEncode(json['notificationTemplates']);
    }
    
    // Handle timestamps
    if (json['created'] != null) {
      program.serverCreated = json['created'];
      try {
        program.createdAt = DateTime.parse(json['created']);
      } catch (e) {}
    }
    
    if (json['lastUpdated'] != null) {
      program.serverLastUpdated = json['lastUpdated'];
      try {
        program.lastUpdatedAt = DateTime.parse(json['lastUpdated']);
      } catch (e) {}
    }
    
    program.dirty = json['dirty'] ?? false;
    
    return program;
  }

  /// Factory constructor from JSON (local)
  factory ProgramIsar.fromJson(Map<String, dynamic> json) {
    final program = ProgramIsar();
    
    program.dhis2Id = json['dhis2Id'] ?? json['id'] ?? '';
    program.name = json['name'] ?? '';
    program.code = json['code'];
    program.version = json['version'];
    program.shortName = json['shortName'];
    program.programType = json['programType'] ?? 'WITH_REGISTRATION';
    program.description = json['description'];
    
    program.displayIncidentDateLabel = json['displayIncidentDateLabel'];
    program.displayEnrollmentDateLabel = json['displayEnrollmentDateLabel'];
    program.incidentDateLabel = json['incidentDateLabel'];
    program.enrollmentDateLabel = json['enrollmentDateLabel'];
    
    program.selectIncidentDatesInFuture = json['selectIncidentDatesInFuture'] ?? false;
    program.selectEnrollmentDatesInFuture = json['selectEnrollmentDatesInFuture'] ?? false;
    program.onlyEnrollOnce = json['onlyEnrollOnce'] ?? false;
    program.displayFrontPageList = json['displayFrontPageList'] ?? false;
    program.useFirstStageDuringRegistration = json['useFirstStageDuringRegistration'] ?? false;
    program.captureCoordinates = json['captureCoordinates'] ?? false;
    program.featureType = json['featureType'];
    program.ignoreOverdueEvents = json['ignoreOverdueEvents'] ?? false;
    program.relationshipFromA = json['relationshipFromA'] ?? false;
    program.selectIncidentDate = json['selectIncidentDate'] ?? false;
    program.selectEnrollmentDate = json['selectEnrollmentDate'] ?? false;
    program.dataEntryMethod = json['dataEntryMethod'] ?? false;
    
    program.completeEventsExpiryDays = json['completeEventsExpiryDays'];
    program.expiryDays = json['expiryDays'];
    program.expiryPeriodType = json['expiryPeriodType'];
    program.minAttributesRequiredToSearch = json['minAttributesRequiredToSearch'];
    program.maxTeiCountToReturn = json['maxTeiCountToReturn'];
    
    program.trackedEntityType = json['trackedEntityType'];
    program.categoryCombo = json['categoryCombo'];
    program.accessLevel = json['accessLevel'];
    
    // Handle serialized collections
    program.programStagesJson = json['programStagesJson'];
    program.programTrackedEntityAttributesJson = json['programTrackedEntityAttributesJson'];
    program.programRulesJson = json['programRulesJson'];
    program.programRuleVariablesJson = json['programRuleVariablesJson'];
    program.attributesJson = json['attributesJson'];
    program.organisationUnitsJson = json['organisationUnitsJson'];
    program.programIndicatorsJson = json['programIndicatorsJson'];
    program.notificationTemplatesJson = json['notificationTemplatesJson'];
    
    // Base properties
    program.createdTimestamp = json['createdTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    program.lastUpdatedTimestamp = json['lastUpdatedTimestamp'] ?? DateTime.now().millisecondsSinceEpoch;
    program.dirty = json['dirty'] ?? false;
    program.synced = json['synced'] ?? false;
    
    return program;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': dhis2Id,
      'dhis2Id': dhis2Id,
      'name': name,
      'code': code,
      'version': version,
      'shortName': shortName,
      'programType': programType,
      'description': description,
      'displayIncidentDateLabel': displayIncidentDateLabel,
      'displayEnrollmentDateLabel': displayEnrollmentDateLabel,
      'incidentDateLabel': incidentDateLabel,
      'enrollmentDateLabel': enrollmentDateLabel,
      'selectIncidentDatesInFuture': selectIncidentDatesInFuture,
      'selectEnrollmentDatesInFuture': selectEnrollmentDatesInFuture,
      'onlyEnrollOnce': onlyEnrollOnce,
      'displayFrontPageList': displayFrontPageList,
      'useFirstStageDuringRegistration': useFirstStageDuringRegistration,
      'captureCoordinates': captureCoordinates,
      'featureType': featureType,
      'ignoreOverdueEvents': ignoreOverdueEvents,
      'relationshipFromA': relationshipFromA,
      'selectIncidentDate': selectIncidentDate,
      'selectEnrollmentDate': selectEnrollmentDate,
      'dataEntryMethod': dataEntryMethod,
      'completeEventsExpiryDays': completeEventsExpiryDays,
      'expiryDays': expiryDays,
      'expiryPeriodType': expiryPeriodType,
      'minAttributesRequiredToSearch': minAttributesRequiredToSearch,
      'maxTeiCountToReturn': maxTeiCountToReturn,
      'trackedEntityType': trackedEntityType,
      'categoryCombo': categoryCombo,
      'accessLevel': accessLevel,
      'programStagesJson': programStagesJson,
      'programTrackedEntityAttributesJson': programTrackedEntityAttributesJson,
      'programRulesJson': programRulesJson,
      'programRuleVariablesJson': programRuleVariablesJson,
      'attributesJson': attributesJson,
      'organisationUnitsJson': organisationUnitsJson,
      'programIndicatorsJson': programIndicatorsJson,
      'notificationTemplatesJson': notificationTemplatesJson,
      'createdTimestamp': createdTimestamp,
      'lastUpdatedTimestamp': lastUpdatedTimestamp,
      'dirty': dirty,
      'synced': synced,
    };
  }

  @override
  String toString() {
    return 'ProgramIsar(dhis2Id: $dhis2Id, name: $name, programType: $programType)';
  }
}

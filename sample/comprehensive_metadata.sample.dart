// Comprehensive performance testing metadata with 500+ items per resource type
// This provides realistic load testing with complex relationships and hierarchies

final Map<String, dynamic> comprehensiveIndicatorsSample = {
  "pager": {"page": 1, "pageCount": 10, "total": 500, "pageSize": 50},
  "indicators": List.generate(500, (index) => {
    "id": "IND${index.toString().padLeft(10, '0')}",
    "name": "Indicator ${index + 1}: ${_getRandomIndicatorName(index)}",
    "shortName": "IND_${index + 1}",
    "code": "IND_CODE_${index + 1}",
    "displayName": "Indicator ${index + 1}: ${_getRandomIndicatorName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "indicatorType": {
      "id": "hmSnCXmLYwt",
      "name": "Per cent",
      "factor": 100,
      "number": false
    },
    "numerator": "#{DE${(index % 50).toString().padLeft(10, '0')}}",
    "denominator": "#{DE${((index + 1) % 50).toString().padLeft(10, '0')}}",
    "annualized": index % 3 == 0,
    "decimals": index % 3,
    "denominatorDescription": "Total population for indicator ${index + 1}",
    "numeratorDescription": "Cases for indicator ${index + 1}",
    "url": index % 10 == 0 ? "https://example.com/indicator_${index}" : null,
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveDataSetsSample = {
  "pager": {"page": 1, "pageCount": 8, "total": 400, "pageSize": 50},
  "dataSets": List.generate(400, (index) => {
    "id": "DS${index.toString().padLeft(10, '0')}",
    "name": "DataSet ${index + 1}: ${_getRandomDataSetName(index)}",
    "shortName": "DS_${index + 1}",
    "code": "DS_CODE_${index + 1}",
    "displayName": "DataSet ${index + 1}: ${_getRandomDataSetName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "periodType": _getRandomPeriodType(index),
    "mobile": index % 2 == 0,
    "version": index % 5 + 1,
    "expiryDays": (index % 30) + 30,
    "timelyDays": (index % 15) + 5,
    "notifyCompletingUser": index % 3 == 0,
    "openFuturePeriods": index % 10,
    "openPeriodsAfterCoEndDate": index % 5,
    "fieldCombinationRequired": index % 4 == 0,
    "validCompleteOnly": index % 5 == 0,
    "noValueRequiresComment": index % 6 == 0,
    "skipOffline": index % 8 == 0,
    "dataElementDecoration": index % 7 == 0,
    "renderAsTabs": index % 3 == 0,
    "renderHorizontally": index % 4 == 0,
    "compulsoryDataElementOperands": [],
    "dataSetElements": List.generate((index % 20) + 5, (deIndex) => {
      "dataElement": {"id": "DE${((index + deIndex) % 200).toString().padLeft(10, '0')}"},
      "categoryCombo": {"id": "CC${((index + deIndex) % 10).toString().padLeft(10, '0')}"}
    }),
    "indicators": List.generate((index % 10), (indIndex) => {
      "id": "IND${((index + indIndex) % 100).toString().padLeft(10, '0')}"
    }),
    "organisationUnits": List.generate((index % 50) + 10, (ouIndex) => {
      "id": "OU${((index + ouIndex) % 1000).toString().padLeft(10, '0')}"
    }),
    "sections": List.generate((index % 5) + 1, (sectionIndex) => {
      "id": "SEC${((index + sectionIndex)).toString().padLeft(10, '0')}",
      "name": "Section ${sectionIndex + 1}",
      "displayName": "Section ${sectionIndex + 1}",
      "sortOrder": sectionIndex,
      "dataElements": List.generate((sectionIndex % 8) + 2, (deIndex) => {
        "id": "DE${((index + sectionIndex + deIndex) % 200).toString().padLeft(10, '0')}"
      })
    }),
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveCategoriesSample = {
  "pager": {"page": 1, "pageCount": 6, "total": 300, "pageSize": 50},
  "categories": List.generate(300, (index) => {
    "id": "CAT${index.toString().padLeft(10, '0')}",
    "name": "Category ${index + 1}: ${_getRandomCategoryName(index)}",
    "shortName": "CAT_${index + 1}",
    "code": "CAT_CODE_${index + 1}",
    "displayName": "Category ${index + 1}: ${_getRandomCategoryName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "dataDimension": index % 2 == 0,
    "dataDimensionType": index % 2 == 0 ? "ATTRIBUTE" : "DISAGGREGATION",
    "categoryOptions": List.generate((index % 10) + 2, (optIndex) => {
      "id": "COPT${((index + optIndex)).toString().padLeft(10, '0')}",
      "name": "Option ${optIndex + 1}",
      "code": "OPT_${index}_${optIndex}",
      "displayName": "Option ${optIndex + 1}",
      "shortName": "Opt_${optIndex + 1}",
      "sortOrder": optIndex
    }),
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveCategoryCombos = {
  "pager": {"page": 1, "pageCount": 4, "total": 200, "pageSize": 50},
  "categoryCombos": List.generate(200, (index) => {
    "id": "CC${index.toString().padLeft(10, '0')}",
    "name": "CategoryCombo ${index + 1}",
    "code": "CC_CODE_${index + 1}",
    "displayName": "CategoryCombo ${index + 1}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "dataDimensionType": "DISAGGREGATION",
    "skipTotal": index % 5 == 0,
    "categories": List.generate((index % 3) + 1, (catIndex) => {
      "id": "CAT${((index + catIndex) % 50).toString().padLeft(10, '0')}"
    }),
    "categoryOptionCombos": List.generate(((index % 3) + 1) * 2, (cocIndex) => {
      "id": "COC${((index + cocIndex)).toString().padLeft(10, '0')}",
      "name": "COC ${cocIndex + 1}",
      "code": "COC_${index}_${cocIndex}",
      "created": "2020-01-01T10:00:00.000",
      "lastUpdated": "2023-01-01T10:00:00.000"
    }),
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveOptionSetsSample = {
  "pager": {"page": 1, "pageCount": 3, "total": 150, "pageSize": 50},
  "optionSets": List.generate(150, (index) => {
    "id": "OS${index.toString().padLeft(10, '0')}",
    "name": "OptionSet ${index + 1}: ${_getRandomOptionSetName(index)}",
    "code": "OS_CODE_${index + 1}",
    "displayName": "OptionSet ${index + 1}: ${_getRandomOptionSetName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "valueType": _getRandomValueType(index),
    "version": index % 5 + 1,
    "options": List.generate((index % 15) + 5, (optIndex) => {
      "id": "OPT${((index * 100) + optIndex).toString().padLeft(10, '0')}",
      "name": "Option ${optIndex + 1}",
      "code": "OPT_${index}_${optIndex}",
      "displayName": "Option ${optIndex + 1}",
      "sortOrder": optIndex,
      "style": optIndex % 5 == 0 ? {
        "color": "#${(optIndex * 111111).toRadixString(16).substring(0, 6)}",
        "icon": "icon_${optIndex}"
      } : null
    }),
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveTrackedEntityTypesSample = {
  "pager": {"page": 1, "pageCount": 2, "total": 100, "pageSize": 50},
  "trackedEntityTypes": List.generate(100, (index) => {
    "id": "TET${index.toString().padLeft(10, '0')}",
    "name": "TrackedEntityType ${index + 1}: ${_getRandomTETName(index)}",
    "code": "TET_CODE_${index + 1}",
    "displayName": "TrackedEntityType ${index + 1}: ${_getRandomTETName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "description": "Description for tracked entity type ${index + 1}",
    "formName": "Form TET ${index + 1}",
    "minAttributesRequiredToSearch": (index % 3) + 1,
    "maxTeiCountToReturn": (index % 500) + 50,
    "allowAuditLog": index % 2 == 0,
    "featureType": _getRandomFeatureType(index),
    "style": index % 10 == 0 ? {
      "color": "#${(index * 111111).toRadixString(16).substring(0, 6)}",
      "icon": "person_${index}"
    } : null,
    "trackedEntityAttributes": List.generate((index % 10) + 3, (attrIndex) => {
      "id": "TEA${((index + attrIndex) % 200).toString().padLeft(10, '0'))}"
    }),
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveTrackedEntityAttributesSample = {
  "pager": {"page": 1, "pageCount": 4, "total": 200, "pageSize": 50},
  "trackedEntityAttributes": List.generate(200, (index) => {
    "id": "TEA${index.toString().padLeft(10, '0')}",
    "name": "Attribute ${index + 1}: ${_getRandomAttributeName(index)}",
    "code": "TEA_CODE_${index + 1}",
    "displayName": "Attribute ${index + 1}: ${_getRandomAttributeName(index)}",
    "shortName": "Attr_${index + 1}",
    "formName": "Form Attr ${index + 1}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "valueType": _getRandomValueType(index),
    "aggregationType": "NONE",
    "unique": index % 20 == 0,
    "inherit": index % 15 == 0,
    "generated": index % 25 == 0,
    "pattern": index % 30 == 0 ? "[A-Z]{3}[0-9]{6}" : null,
    "sortOrderInListNoProgram": index,
    "displayInListNoProgram": index % 3 != 0,
    "confidential": index % 50 == 0,
    "displayOnVisitSchedule": index % 10 == 0,
    "displayDescription": index % 2 == 0 ? "Description for attribute ${index + 1}" : null,
    "formDescription": index % 3 == 0 ? "Form description for attribute ${index + 1}" : null,
    "optionSet": index % 10 == 0 ? {
      "id": "OS${(index ~/ 10).toString().padLeft(10, '0')}"
    } : null,
    "legendSet": index % 15 == 0 ? {
      "id": "LS${(index ~/ 15).toString().padLeft(10, '0')}"
    } : null,
    "dirty": false
  })
};

final Map<String, dynamic> comprehensiveValidationRulesSample = {
  "pager": {"page": 1, "pageCount": 3, "total": 150, "pageSize": 50},
  "validationRules": List.generate(150, (index) => {
    "id": "VR${index.toString().padLeft(10, '0')}",
    "name": "ValidationRule ${index + 1}: ${_getRandomValidationRuleName(index)}",
    "code": "VR_CODE_${index + 1}",
    "displayName": "ValidationRule ${index + 1}: ${_getRandomValidationRuleName(index)}",
    "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
    "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
    "description": "Validation rule to check ${_getRandomValidationRuleName(index)}",
    "instruction": "Instruction for validation rule ${index + 1}",
    "importance": _getRandomImportance(index),
    "operator": _getRandomOperator(index),
    "periodType": _getRandomPeriodType(index),
    "skipFormValidation": index % 5 == 0,
    "leftSide": {
      "description": "Left side expression",
      "expression": "#{DE${(index % 50).toString().padLeft(10, '0')}}",
      "missingValueStrategy": "SKIP_IF_ANY_VALUE_MISSING"
    },
    "rightSide": {
      "description": "Right side expression", 
      "expression": "#{DE${((index + 1) % 50).toString().padLeft(10, '0')}} + 10",
      "missingValueStrategy": "SKIP_IF_ALL_VALUES_MISSING"
    },
    "organisationUnitLevels": List.generate((index % 3) + 1, (level) => level + 1),
    "dirty": false
  })
};

// Helper functions to generate realistic names and values
String _getRandomIndicatorName(int index) {
  final names = [
    "Immunization Coverage Rate",
    "Maternal Mortality Ratio", 
    "Child Malnutrition Rate",
    "TB Treatment Success Rate",
    "HIV Testing Coverage",
    "Malaria Incidence Rate",
    "Antenatal Care Coverage",
    "Skilled Birth Attendance",
    "Under-5 Mortality Rate",
    "Contraceptive Prevalence Rate"
  ];
  return names[index % names.length];
}

String _getRandomDataSetName(int index) {
  final names = [
    "Primary Healthcare Monthly",
    "District Hospital Weekly",
    "Maternal Health Quarterly",
    "Child Health Annual",
    "TB Program Monthly",
    "HIV/AIDS Quarterly",
    "Malaria Control Weekly",
    "Nutrition Program Monthly",
    "Community Health Daily",
    "Vaccination Campaign"
  ];
  return names[index % names.length];
}

String _getRandomCategoryName(int index) {
  final names = [
    "Age Group",
    "Gender",
    "Location Type",
    "Service Type",
    "Population Group",
    "Funding Source",
    "Program Type",
    "Facility Level",
    "Treatment Type",
    "Risk Category"
  ];
  return names[index % names.length];
}

String _getRandomOptionSetName(int index) {
  final names = [
    "Yes/No Options",
    "Age Groups",
    "Education Levels", 
    "Employment Status",
    "Marital Status",
    "Treatment Outcomes",
    "Severity Levels",
    "Priority Levels",
    "Risk Factors",
    "Service Providers"
  ];
  return names[index % names.length];
}

String _getRandomTETName(int index) {
  final names = [
    "Person",
    "Patient",
    "Child",
    "Mother", 
    "Healthcare Worker",
    "Community Member",
    "Student",
    "Facility",
    "Equipment",
    "Vehicle"
  ];
  return names[index % names.length];
}

String _getRandomAttributeName(int index) {
  final names = [
    "First Name",
    "Last Name", 
    "Date of Birth",
    "Gender",
    "Phone Number",
    "Address",
    "National ID",
    "Email Address",
    "Occupation",
    "Emergency Contact"
  ];
  return names[index % names.length];
}

String _getRandomValidationRuleName(int index) {
  final names = [
    "Data Completeness Check",
    "Logical Data Consistency",
    "Value Range Validation",
    "Sum Total Verification",
    "Percentage Calculation Check",
    "Cross-Variable Validation",
    "Temporal Consistency Check",
    "Mandatory Field Validation",
    "Duplicate Entry Check",
    "Reference Data Integrity"
  ];
  return names[index % names.length];
}

String _getRandomPeriodType(int index) {
  final types = [
    "Monthly",
    "Quarterly", 
    "Yearly",
    "Weekly",
    "Daily",
    "SixMonthly",
    "BiMonthly",
    "TwoYearly"
  ];
  return types[index % types.length];
}

String _getRandomValueType(int index) {
  final types = [
    "TEXT",
    "NUMBER",
    "INTEGER",
    "POSITIVE_INT",
    "NEGATIVE_INT",
    "ZERO_OR_POSITIVE_INT",
    "BOOLEAN",
    "TRUE_ONLY",
    "DATE",
    "DATETIME",
    "TIME",
    "LONG_TEXT",
    "EMAIL",
    "PHONE_NUMBER",
    "URL",
    "FILE_RESOURCE",
    "COORDINATE",
    "ORGANISATION_UNIT",
    "AGE",
    "PERCENTAGE"
  ];
  return types[index % types.length];
}

String _getRandomFeatureType(int index) {
  final types = ["NONE", "POINT", "POLYGON", "MULTI_POLYGON"];
  return types[index % types.length];
}

String _getRandomImportance(int index) {
  final levels = ["LOW", "MEDIUM", "HIGH"];
  return levels[index % levels.length];
}

String _getRandomOperator(int index) {
  final operators = [
    "equal_to",
    "not_equal_to",
    "greater_than",
    "greater_than_or_equal_to",
    "less_than",
    "less_than_or_equal_to",
    "compulsory_pair",
    "exclusive_pair"
  ];
  return operators[index % operators.length];
}

// Large organisation unit structure with complex hierarchies
final Map<String, dynamic> comprehensiveOrgUnitsSample = {
  "pager": {"page": 1, "pageCount": 20, "total": 1000, "pageSize": 50},
  "organisationUnits": List.generate(1000, (index) => {
    final level = (index < 10) ? 1 : 
                 (index < 110) ? 2 : 
                 (index < 610) ? 3 : 4;
    
    final parentId = level == 1 ? null :
                    level == 2 ? "OU${(index % 10).toString().padLeft(10, '0')}" :
                    level == 3 ? "OU${((index % 100) + 10).toString().padLeft(10, '0')}" :
                    "OU${((index % 500) + 110).toString().padLeft(10, '0')}";
    
    return {
      "id": "OU${index.toString().padLeft(10, '0')}",
      "name": "${_getOrgUnitLevelName(level)} ${(index % _getMaxPerLevel(level)) + 1}",
      "code": "OU_CODE_${index}",
      "displayName": "${_getOrgUnitLevelName(level)} ${(index % _getMaxPerLevel(level)) + 1}",
      "shortName": "${_getOrgUnitLevelName(level)}_${(index % _getMaxPerLevel(level)) + 1}",
      "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
      "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
      "level": level,
      "path": _generateOrgUnitPath(index, level),
      "parent": parentId != null ? {"id": parentId} : null,
      "openingDate": "2010-01-01T00:00:00.000",
      "closedDate": index % 100 == 0 ? "2023-12-31T00:00:00.000" : null,
      "comment": index % 20 == 0 ? "Comment for org unit ${index}" : null,
      "url": index % 50 == 0 ? "https://facility${index}.example.com" : null,
      "contactPerson": index % 15 == 0 ? "Contact Person ${index}" : null,
      "address": index % 10 == 0 ? "Address ${index}, City ${index % 50}" : null,
      "email": index % 25 == 0 ? "facility${index}@example.com" : null,
      "phoneNumber": index % 30 == 0 ? "+1-555-${(index % 9000 + 1000)}" : null,
      "coordinates": index % 20 == 0 ? "[${-180 + (index % 360)}, ${-90 + (index % 180)}]" : null,
      "featureType": index % 40 == 0 ? "POINT" : "NONE",
      "geometry": index % 30 == 0 ? {
        "type": "Point",
        "coordinates": [-180 + (index % 360), -90 + (index % 180)]
      } : null,
      "dirty": false
    };
  })
};

String _getOrgUnitLevelName(int level) {
  switch (level) {
    case 1: return "Country";
    case 2: return "Region"; 
    case 3: return "District";
    case 4: return "Facility";
    default: return "Unit";
  }
}

int _getMaxPerLevel(int level) {
  switch (level) {
    case 1: return 10;
    case 2: return 100; 
    case 3: return 500;
    case 4: return 390;
    default: return 100;
  }
}

String _generateOrgUnitPath(int index, int level) {
  switch (level) {
    case 1: return "/OU${index.toString().padLeft(10, '0')}";
    case 2: return "/OU${(index % 10).toString().padLeft(10, '0')}/OU${index.toString().padLeft(10, '0')}";
    case 3: return "/OU${(index % 10).toString().padLeft(10, '0')}/OU${((index % 100) + 10).toString().padLeft(10, '0')}/OU${index.toString().padLeft(10, '0')}";
    case 4: return "/OU${(index % 10).toString().padLeft(10, '0')}/OU${((index % 100) + 10).toString().padLeft(10, '0')}/OU${((index % 500) + 110).toString().padLeft(10, '0')}/OU${index.toString().padLeft(10, '0')}";
    default: return "/OU${index.toString().padLeft(10, '0')}";
  }
}

// Comprehensive Programs with complex relationships
final Map<String, dynamic> comprehensiveProgramsSample = {
  "pager": {"page": 1, "pageCount": 10, "total": 500, "pageSize": 50},
  "programs": List.generate(500, (index) => {
    final isTracker = index % 3 != 0;
    
    return {
      "id": "PROG${index.toString().padLeft(10, '0')}",
      "name": "Program ${index + 1}: ${_getRandomProgramName(index)}",
      "shortName": "PROG_${index + 1}",
      "code": "PROG_CODE_${index + 1}",
      "displayName": "Program ${index + 1}: ${_getRandomProgramName(index)}",
      "created": "2020-01-01T10:${(index % 60).toString().padLeft(2, '0')}:00.000",
      "lastUpdated": "2023-${((index % 12) + 1).toString().padLeft(2, '0')}-01T10:00:00.000",
      "description": "Comprehensive program ${index + 1} for ${_getRandomProgramName(index)}",
      "version": index % 3 + 1,
      "enrollmentDateLabel": "Enrollment Date",
      "incidentDateLabel": isTracker ? "Incident Date" : null,
      "programType": isTracker ? "WITH_REGISTRATION" : "WITHOUT_REGISTRATION",
      "displayIncidentDate": isTracker && (index % 2 == 0),
      "onlyEnrollOnce": isTracker && (index % 3 == 0),
      "selectEnrollmentDatesInFuture": isTracker && (index % 4 == 0),
      "selectIncidentDatesInFuture": isTracker && (index % 5 == 0),
      "ignoreOverdueEvents": index % 6 == 0,
      "useFirstStageDuringRegistration": isTracker && (index % 3 == 0),
      "displayFrontPageList": index % 2 == 0,
      "skipOffline": index % 10 == 0,
      "captureCoordinates": index % 4 == 0,
      "featureType": index % 4 == 0 ? _getRandomFeatureType(index) : "NONE",
      "relatedProgram": index % 20 == 0 ? {
        "id": "PROG${((index + 50) % 500).toString().padLeft(10, '0')}"
      } : null,
      "trackedEntityType": isTracker ? {
        "id": "TET${(index % 20).toString().padLeft(10, '0')}"
      } : null,
      "categoryCombo": {
        "id": "CC${(index % 50).toString().padLeft(10, '0')}"
      },
      "withoutRegistration": !isTracker,
      "minAttributesRequiredToSearch": isTracker ? (index % 3) + 1 : null,
      "maxTeiCountToReturn": isTracker ? (index % 500) + 50 : null,
      "accessLevel": _getRandomAccessLevel(index),
      "expiryPeriodType": index % 5 == 0 ? _getRandomPeriodType(index) : null,
      "expiryDays": index % 5 == 0 ? (index % 365) + 30 : 0,
      "completeEventsExpiryDays": (index % 180) + 30,
      "programTrackedEntityAttributes": isTracker ? List.generate((index % 8) + 3, (attrIndex) => {
        "id": "PTEA${((index + attrIndex)).toString().padLeft(10, '0')}",
        "name": "Program Tracked Entity Attribute ${attrIndex + 1}",
        "displayName": "Program TEA ${attrIndex + 1}",
        "mandatory": attrIndex < 2,
        "allowFutureDate": attrIndex % 3 == 0,
        "displayInList": attrIndex % 2 == 0,
        "searchable": attrIndex % 4 != 0,
        "sortOrder": attrIndex,
        "renderOptionsAsRadio": false,
        "trackedEntityAttribute": {
          "id": "TEA${((index + attrIndex) % 100).toString().padLeft(10, '0')}"
        }
      }) : [],
      "programStages": List.generate((index % 5) + 1, (stageIndex) => {
        "id": "PS${((index * 10) + stageIndex).toString().padLeft(10, '0')}",
        "name": "Stage ${stageIndex + 1}",
        "displayName": "Stage ${stageIndex + 1}",
        "description": "Program stage ${stageIndex + 1}",
        "repeatable": stageIndex > 0 && (stageIndex % 3 == 0),
        "sortOrder": stageIndex,
        "minDaysFromStart": stageIndex * 30,
        "standardInterval": stageIndex == 0 ? null : 30,
        "executionDateLabel": "Visit Date",
        "dueDateLabel": "Due Date", 
        "allowGenerateNextVisit": stageIndex > 0,
        "generatedByEnrollmentDate": stageIndex == 0,
        "autoGenerateEvent": stageIndex == 0,
        "blockEntryForm": false,
        "hideDueDate": false,
        "enableUserAssignment": stageIndex % 2 == 0,
        "captureCoordinates": stageIndex % 3 == 0,
        "featureType": stageIndex % 3 == 0 ? "POINT" : "NONE",
        "formType": "DEFAULT",
        "openAfterEnrollment": stageIndex == 0,
        "reportDateToUse": "incidentDate",
        "preGenerateUID": false,
        "remindCompleted": false,
        "validationStrategy": "ON_COMPLETE",
        "displayGenerateEventBox": true,
        "programStageDataElements": List.generate((stageIndex % 15) + 5, (deIndex) => {
          "id": "PSDE${((index * 100) + (stageIndex * 10) + deIndex).toString().padLeft(10, '0')}",
          "compulsory": deIndex < 3,
          "allowFutureDate": deIndex % 4 == 0,
          "displayInReports": deIndex % 2 == 0,
          "allowProvidedElsewhere": deIndex % 5 == 0,
          "sortOrder": deIndex,
          "skipSynchronization": false,
          "renderOptionsAsRadio": false,
          "dataElement": {
            "id": "DE${((index + stageIndex + deIndex) % 200).toString().padLeft(10, '0')}"
          }
        }),
        "programStageSections": stageIndex % 2 == 0 ? List.generate((stageIndex % 3) + 1, (secIndex) => {
          "id": "PSS${((index * 100) + (stageIndex * 10) + secIndex).toString().padLeft(10, '0')}",
          "name": "Section ${secIndex + 1}",
          "displayName": "Section ${secIndex + 1}",
          "sortOrder": secIndex,
          "renderType": {
            "MOBILE": {"type": secIndex % 2 == 0 ? "LISTING" : "SEQUENTIAL"},
            "DESKTOP": {"type": "LISTING"}
          },
          "dataElements": List.generate((secIndex % 5) + 2, (deIndex) => {
            "dataElement": "DE${((index + stageIndex + secIndex + deIndex) % 200).toString().padLeft(10, '0'))}"
          })
        }) : []
      }),
      "programSections": isTracker && (index % 3 == 0) ? List.generate((index % 3) + 1, (secIndex) => {
        "id": "PS${((index * 10) + secIndex).toString().padLeft(10, '0')}",
        "name": "Program Section ${secIndex + 1}",
        "displayName": "Program Section ${secIndex + 1}",
        "description": "Section ${secIndex + 1} description",
        "sortOrder": secIndex,
        "renderType": {
          "MOBILE": {"type": "LISTING"},
          "DESKTOP": {"type": "LISTING"}
        },
        "trackedEntityAttributes": List.generate((secIndex % 4) + 1, (attrIndex) => {
          "attribute": "TEA${((index + secIndex + attrIndex) % 100).toString().padLeft(10, '0'))}"
        })
      }) : [],
      "programRuleVariables": List.generate((index % 10), (varIndex) => {
        "id": "PRV${((index * 10) + varIndex).toString().padLeft(10, '0')}",
        "name": "variable_${varIndex}",
        "displayName": "Program Rule Variable ${varIndex + 1}",
        "programRuleVariableSourceType": _getRandomVariableSourceType(varIndex),
        "useCodeForOptionSet": varIndex % 2 == 0,
        "dataElement": varIndex % 2 == 0 ? {
          "id": "DE${((index + varIndex) % 200).toString().padLeft(10, '0')}"
        } : null,
        "trackedEntityAttribute": varIndex % 2 != 0 ? {
          "id": "TEA${((index + varIndex) % 100).toString().padLeft(10, '0')}"
        } : null
      }),
      "programRules": List.generate((index % 8), (ruleIndex) => {
        "id": "PR${((index * 10) + ruleIndex).toString().padLeft(10, '0')}",
        "name": "Program Rule ${ruleIndex + 1}",
        "displayName": "Program Rule ${ruleIndex + 1}",
        "description": "Program rule ${ruleIndex + 1} description",
        "priority": ruleIndex + 1,
        "condition": "true",
        "programRuleActions": List.generate((ruleIndex % 3) + 1, (actionIndex) => {
          "id": "PRA${((index * 100) + (ruleIndex * 10) + actionIndex).toString().padLeft(10, '0')}",
          "programRuleActionType": _getRandomRuleActionType(actionIndex),
          "dataElement": actionIndex % 2 == 0 ? {
            "id": "DE${((index + ruleIndex + actionIndex) % 200).toString().padLeft(10, '0')}"
          } : null,
          "trackedEntityAttribute": actionIndex % 2 != 0 ? {
            "id": "TEA${((index + ruleIndex + actionIndex) % 100).toString().padLeft(10, '0')}"
          } : null,
          "data": "Action data ${actionIndex}",
          "content": "Action content ${actionIndex}"
        })
      }),
      "organisationUnits": List.generate((index % 100) + 10, (ouIndex) => {
        "id": "OU${((index + ouIndex) % 1000).toString().padLeft(10, '0')}"
      }),
      "dirty": false
    };
  })
};

String _getRandomProgramName(int index) {
  final names = [
    "Child Health Program",
    "Maternal Care Program",
    "TB Treatment Program", 
    "HIV Prevention Program",
    "Malaria Control Program",
    "Nutrition Program",
    "Immunization Program",
    "Family Planning Program",
    "Mental Health Program",
    "Non-Communicable Disease Program"
  ];
  return names[index % names.length];
}

String _getRandomAccessLevel(int index) {
  final levels = ["OPEN", "AUDITED", "PROTECTED", "CLOSED"];
  return levels[index % levels.length];
}

String _getRandomVariableSourceType(int index) {
  final types = [
    "DATAELEMENT_CURRENT_EVENT",
    "DATAELEMENT_PREVIOUS_EVENT", 
    "DATAELEMENT_NEWEST_EVENT_PROGRAM_STAGE",
    "DATAELEMENT_NEWEST_EVENT_PROGRAM",
    "TEI_ATTRIBUTE",
    "CALCULATED_VALUE"
  ];
  return types[index % types.length];
}

String _getRandomRuleActionType(int index) {
  final types = [
    "DISPLAYTEXT",
    "DISPLAYKEYVALUEPAIR",
    "HIDEFIELD",
    "HIDESECTION", 
    "HIDEPROGRAMSTAGE",
    "ASSIGN",
    "SHOWWARNING",
    "SHOWERROR",
    "WARNINGONCOMPLETE",
    "ERRORONCOMPLETE",
    "CREATEEVENT",
    "SETMANDATORYFIELD",
    "SENDMESSAGE",
    "SCHEDULEMESSAGE"
  ];
  return types[index % types.length];
}

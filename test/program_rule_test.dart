import 'package:dhis2_flutter_sdk/modules/engines/program_rule/interfaces/program_rule_engine.models.dart';
import 'package:dhis2_flutter_sdk/modules/engines/program_rule/services/engine.service.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:dhis2_flutter_sdk/d2_touch.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final dynamic testSampleJson = {
    "eventsData": {
      "id": "e6uCAGJdBcr",
      "event": "e6uCAGJdBcr",
      "eventDate": "2020-09-25",
      "dueDate": "2020-09-25",
      "program": "ib6PYHQ5Aa8",
      "programStage": "ZjGk4Xvo5r9",
      "orgUnit": "VN8Jjz61jOE",
      "trackedEntityInstance": "sfIC7KC2OXF",
      "status": "ACTIVE",
      "dataValues": [
        {"dataElement": "UOc2zNtYCAt", "value": "33332"},
        {"dataElement": "ynTZOe2zzPD", "value": "Male"},
        {"dataElement": "jJd1ieyyrrM", "value": "Yes"},
        {"dataElement": "uHUGHCcKAQB", "value": "Positive"},
        {"dataElement": "Wd6shffAm5E", "value": "Yes"},
        {"dataElement": "m68e2mT1f1Y", "value": "Yes"},
        {"dataElement": "ZVV4PtiYh7A", "value": "Imported"}
      ],
      "deleted": "false",
      "enrollment": "Tf4WlXXTdb5",
      "synced": false
    },
    "dataElements": {
      "UOc2zNtYCAt": {
        "name": "Re-Index ID",
        "id": "UOc2zNtYCAt",
        "shortName": "Re-Index ID",
        "aggregationType": "SUM",
        "displayName": "Re-Index ID",
        "valueType": "NUMBER",
        "optionSetValue": false
      },
      "sw4EAynyI60": {
        "name": "Re-Village of residence",
        "id": "sw4EAynyI60",
        "shortName": "Re-Village of residence",
        "aggregationType": "SUM",
        "displayName": "Re-Village of residence",
        "valueType": "ORGANISATION_UNIT",
        "optionSetValue": false
      },
      "IgsZFHZYbVJ": {
        "name": "Re- Date of visit",
        "id": "IgsZFHZYbVJ",
        "shortName": "Re- Date of visit",
        "aggregationType": "SUM",
        "displayName": "Re- Date of visit",
        "valueType": "DATE",
        "optionSetValue": false
      },
      "FXFcNI1Oyb0": {
        "name": "Re-ACD Case ID",
        "id": "FXFcNI1Oyb0",
        "shortName": "Re-ACD Case ID",
        "aggregationType": "COUNT",
        "displayName": "Re-ACD Case ID",
        "valueType": "NUMBER",
        "optionSetValue": false
      },
      "nKoKDmJN01l": {
        "name": "Re-ACD name",
        "id": "nKoKDmJN01l",
        "shortName": "Re-ACD name",
        "aggregationType": "NONE",
        "displayName": "Re-ACD name",
        "valueType": "TEXT",
        "optionSetValue": false
      },
      "d1mXAqnn775": {
        "name": "Re-ACD Age",
        "id": "d1mXAqnn775",
        "shortName": "Re-ACD Age",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Age",
        "valueType": "INTEGER_ZERO_OR_POSITIVE",
        "optionSetValue": false
      },
      "ynTZOe2zzPD": {
        "name": "Re-ACD Sex",
        "id": "ynTZOe2zzPD",
        "shortName": "Re-ACD Sex",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Sex",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Sex",
          "id": "ZnVLoAp2WRb",
          "options": [
            {
              "code": "Male",
              "name": "Male",
              "id": "sHZeC3hmKwG",
              "sortOrder": 1
            },
            {
              "code": "Female",
              "name": "Female",
              "id": "k9uPFST6kxm",
              "sortOrder": 2
            }
          ]
        }
      },
      "RXhlMxMPEFI": {
        "name": "Re-Occupation",
        "id": "RXhlMxMPEFI",
        "shortName": "Re-Occupation",
        "aggregationType": "NONE",
        "displayName": "Re-Occupation",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "mCBS Occupation",
          "id": "WHVLpT4CHR8",
          "options": [
            {
              "code": "Peasants",
              "name": "Peasants",
              "id": "T18S9XFvhsU",
              "sortOrder": 1
            },
            {
              "code": "Business",
              "name": "Business",
              "id": "DWc7Q0zNJsW",
              "sortOrder": 2
            },
            {
              "code": "Employee",
              "name": "Employee",
              "id": "ghur6sYFlZM",
              "sortOrder": 3
            },
            {
              "code": "Pastoralist",
              "name": "Pastoralist",
              "id": "LB3TR74fTmE",
              "sortOrder": 4
            },
            {
              "code": "Pupil/Student",
              "name": "Pupil/Student",
              "id": "LIeBDW6msbP",
              "sortOrder": 5
            },
            {
              "code": "Unemployed",
              "name": "Unemployed",
              "id": "ujqDrnDfURm",
              "sortOrder": 6
            },
            {
              "code": "Others",
              "name": "Others",
              "id": "dQpHo97tdU0",
              "sortOrder": 7
            }
          ]
        }
      },
      "rt8o34GLnwn": {
        "name": "Re-Relation with index case",
        "id": "rt8o34GLnwn",
        "shortName": "Re-Relation with index case",
        "aggregationType": "NONE",
        "displayName": "Re-Relation with index case",
        "valueType": "TEXT",
        "optionSetValue": false
      },
      "jJd1ieyyrrM": {
        "name": "Re-ACD Tested",
        "id": "jJd1ieyyrrM",
        "shortName": "Re-ACD Tested",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Tested",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Yes/No",
          "id": "WYVdsz7yuus",
          "options": [
            {"code": "Yes", "name": "Yes", "id": "OvWxPYgMpSA", "sortOrder": 1},
            {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
          ]
        }
      },
      "uHUGHCcKAQB": {
        "name": "Re-ACD Test Result",
        "id": "uHUGHCcKAQB",
        "shortName": "Re-ACD Test Result",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Test Result",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Test Result (Positive/Negative)",
          "id": "aoVRajRJe9U",
          "options": [
            {
              "code": "Negative",
              "name": "Negative",
              "id": "u5zfYcJOAhn",
              "sortOrder": 1
            },
            {
              "code": "Positive",
              "name": "Positive",
              "id": "hhCLkio1gZg",
              "sortOrder": 2
            }
          ]
        }
      },
      "Wd6shffAm5E": {
        "name": "Re-ACD Fever or History of fever in the past 3 days",
        "id": "Wd6shffAm5E",
        "shortName": "Re-ACD Fever or History of fever in the past 3 ",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Fever or History of fever in the past 3 days",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Yes/No",
          "id": "WYVdsz7yuus",
          "options": [
            {"code": "Yes", "name": "Yes", "id": "OvWxPYgMpSA", "sortOrder": 1},
            {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
          ]
        }
      },
      "m68e2mT1f1Y": {
        "name": "Re-ACD Travel in the past 4 weeks",
        "id": "m68e2mT1f1Y",
        "shortName": "Re-ACD Travel in the past 4 weeks",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Travel in the past 4 weeks",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Yes/No",
          "id": "WYVdsz7yuus",
          "options": [
            {"code": "Yes", "name": "Yes", "id": "OvWxPYgMpSA", "sortOrder": 1},
            {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
          ]
        }
      },
      "Nrmpp5Em3fQ": {
        "name": "Re-ACD Place of travel",
        "id": "Nrmpp5Em3fQ",
        "shortName": "Re-ACD Place of travel",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Place of travel",
        "valueType": "ORGANISATION_UNIT",
        "optionSetValue": false
      },
      "VEWB20kDYX3": {
        "name": "Re-ACD Travel Period From",
        "id": "VEWB20kDYX3",
        "shortName": "Re-ACD Travel Period From",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Travel Period From",
        "valueType": "DATE",
        "optionSetValue": false
      },
      "UZIHjzdqppz": {
        "name": "Re-ACD Travel Period To",
        "id": "UZIHjzdqppz",
        "shortName": "Re-ACD Travel Period To",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Travel Period To",
        "valueType": "DATE",
        "optionSetValue": false
      },
      "ZVV4PtiYh7A": {
        "name": "Re-ACD Case classification",
        "id": "ZVV4PtiYh7A",
        "shortName": "Re-ACD Case classification",
        "aggregationType": "NONE",
        "displayName": "Re-ACD Case classification",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "mCBS Case classification",
          "id": "F9u147kfpdR",
          "options": [
            {
              "code": "Local",
              "name": "Local",
              "id": "iLrQEBgX7ni",
              "sortOrder": 1
            },
            {
              "code": "Imported",
              "name": "Imported",
              "id": "ZTwy5LOATsz",
              "sortOrder": 2
            }
          ]
        }
      },
      "GN8P1YHW5mY": {
        "name":
            "Re-If local, current foci classification, follow provided job aids",
        "id": "GN8P1YHW5mY",
        "shortName": "Re-If local, current foci classification",
        "aggregationType": "NONE",
        "displayName":
            "Re-If local, current foci classification, follow provided job aids",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "mCBS foci classification",
          "id": "rCMKujau63m",
          "options": [
            {
              "code": "Active",
              "name": "Active",
              "id": "EIZaimsLJhr",
              "sortOrder": 1
            },
            {
              "code": "Residue non active",
              "name": "Residue non active",
              "id": "OEjo0Y40acm",
              "sortOrder": 2
            },
            {
              "code": "Cleared",
              "name": "Cleared",
              "id": "YvQB0vxLNsc",
              "sortOrder": 3
            }
          ]
        }
      },
      "SFpdcuZMW6W": {
        "name":
            "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
        "id": "SFpdcuZMW6W",
        "shortName": "Re-known malaria Fever Case within same household",
        "aggregationType": "NONE",
        "displayName":
            "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "Yes/No",
          "id": "WYVdsz7yuus",
          "options": [
            {"code": "Yes", "name": "Yes", "id": "OvWxPYgMpSA", "sortOrder": 1},
            {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
          ]
        }
      },
      "MiIDFmt7MYg": {
        "name": "Re-Local case classification",
        "id": "MiIDFmt7MYg",
        "shortName": "Re-Local case classification",
        "aggregationType": "NONE",
        "displayName": "Re-Local case classification",
        "valueType": "TEXT",
        "optionSetValue": true,
        "optionSet": {
          "name": "mCBS Local case classification ",
          "id": "uRToOtz3mHQ",
          "options": [
            {
              "code": "Indigenous",
              "name": "Indigenous",
              "id": "VORTUj2KLC5",
              "sortOrder": 1
            },
            {
              "code": "Introduced",
              "name": "Introduced",
              "id": "N3Z9omb7XXt",
              "sortOrder": 2
            }
          ]
        }
      }
    },
    "programRules": [
      {
        "id": "B50S6aoeIoT",
        "name": "Re-ACD Hiding fields if client not tested",
        "displayName": "Re-ACD Hiding fields if client not tested",
        "lastUpdated": "2020-09-15T12:36:47.477",
        "created": "2020-09-15T12:36:47.477",
        "condition": "#{Re-ACD Test} == 'No'",
        "programRuleActions": [
          {
            "created": "2020-09-15T12:36:47.349",
            "lastUpdated": "2020-09-15T12:36:47.349",
            "id": "Dz4VgRQINfy",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-ACD Fever or History of fever in the past 3 days",
              "id": "Wd6shffAm5E",
              "shortName": "Re-ACD Fever or History of fever in the past 3 ",
              "aggregationType": "NONE",
              "displayName":
                  "Re-ACD Fever or History of fever in the past 3 days",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "Yes/No",
                "id": "WYVdsz7yuus",
                "options": [
                  {
                    "code": "Yes",
                    "name": "Yes",
                    "id": "OvWxPYgMpSA",
                    "sortOrder": 1
                  },
                  {
                    "code": "No",
                    "name": "No",
                    "id": "xXPM0UG0rsn",
                    "sortOrder": 2
                  }
                ]
              }
            },
            "programRule": {"id": "B50S6aoeIoT"}
          },
          {
            "created": "2020-09-15T12:36:47.349",
            "lastUpdated": "2020-09-15T12:36:47.349",
            "id": "HIaKwwv8Fri",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-ACD Test Result",
              "id": "uHUGHCcKAQB",
              "shortName": "Re-ACD Test Result",
              "aggregationType": "NONE",
              "displayName": "Re-ACD Test Result",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "Test Result (Positive/Negative)",
                "id": "aoVRajRJe9U",
                "options": [
                  {
                    "code": "Negative",
                    "name": "Negative",
                    "id": "u5zfYcJOAhn",
                    "sortOrder": 1
                  },
                  {
                    "code": "Positive",
                    "name": "Positive",
                    "id": "hhCLkio1gZg",
                    "sortOrder": 2
                  }
                ]
              }
            },
            "programRule": {"id": "B50S6aoeIoT"}
          }
        ]
      },
      {
        "id": "DD1gA7wtxnI",
        "name": "mCBS MCR Hiding fields if the case is imported",
        "displayName": "mCBS MCR Hiding fields if the case is imported",
        "lastUpdated": "2020-09-20T08:26:25.905",
        "created": "2020-09-20T08:26:25.905",
        "condition": "A{Case classification} == 'Imported'",
        "programRuleActions": [
          {
            "created": "2020-09-20T08:26:25.785",
            "lastUpdated": "2020-09-20T08:26:25.785",
            "id": "qLiaxXW18hA",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name": "If local, current foci classification",
              "id": "nXeOcMvi9Os",
              "shortName": "If local, current foci classification",
              "generated": false,
              "displayName": "If local, current foci classification",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "code": "If local, current foci classification",
                "name": "If local, current foci classification",
                "id": "jxNWsxR7RLh",
                "options": [
                  {
                    "code": "Active",
                    "name": "Active",
                    "id": "bsH8XMq0eXz",
                    "sortOrder": 1
                  },
                  {
                    "code": " Residue non active",
                    "name": " Residue non active",
                    "id": "jVR6KaitQly",
                    "sortOrder": 2
                  },
                  {
                    "code": "Cleared",
                    "name": "Cleared",
                    "id": "yhaE0Jzrojf",
                    "sortOrder": 3
                  }
                ]
              }
            },
            "programRule": {"id": "DD1gA7wtxnI"}
          },
          {
            "created": "2020-09-20T08:26:25.785",
            "lastUpdated": "2020-09-20T08:26:25.785",
            "id": "n3HIBVJGeBm",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name":
                  "Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
              "id": "R3IQKrwOfH0",
              "shortName": "mCBS Any known malaria",
              "generated": false,
              "displayName":
                  "Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
              "valueType": "BOOLEAN",
              "optionSetValue": false
            },
            "programRule": {"id": "DD1gA7wtxnI"}
          },
          {
            "created": "2020-09-20T08:26:25.785",
            "lastUpdated": "2020-09-20T08:26:25.785",
            "id": "KYSY9WBTZ6x",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name": "Local case classification ",
              "id": "uAnFHvxxITx",
              "shortName": "mCBS Local case classification ",
              "generated": false,
              "displayName": "Local case classification ",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "mCBS Local case classification ",
                "id": "uRToOtz3mHQ",
                "options": [
                  {
                    "code": "Indigenous",
                    "name": "Indigenous",
                    "id": "VORTUj2KLC5",
                    "sortOrder": 1
                  },
                  {
                    "code": "Introduced",
                    "name": "Introduced",
                    "id": "N3Z9omb7XXt",
                    "sortOrder": 2
                  }
                ]
              }
            },
            "programRule": {"id": "DD1gA7wtxnI"}
          }
        ]
      },
      {
        "id": "IrFmmQnkQVv",
        "name": "Re-ACD Hiding fields if not traveled in the past 4 weeks",
        "displayName":
            "Re-ACD Hiding fields if not traveled in the past 4 weeks",
        "lastUpdated": "2020-09-15T12:39:06.921",
        "created": "2020-09-15T12:39:06.921",
        "condition": "#{Re-ACD Travel the in the past 4 weeks} == 'No'",
        "programRuleActions": [
          {
            "created": "2020-09-15T12:39:06.784",
            "lastUpdated": "2020-09-15T12:39:06.784",
            "id": "fd7nV6ncvzh",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-ACD Travel Period To",
              "id": "UZIHjzdqppz",
              "shortName": "Re-ACD Travel Period To",
              "aggregationType": "NONE",
              "displayName": "Re-ACD Travel Period To",
              "valueType": "DATE",
              "optionSetValue": false
            },
            "programRule": {"id": "IrFmmQnkQVv"}
          },
          {
            "created": "2020-09-15T12:39:06.784",
            "lastUpdated": "2020-09-15T12:39:06.784",
            "id": "mywHUk5vUlW",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-ACD Place of travel",
              "id": "Nrmpp5Em3fQ",
              "shortName": "Re-ACD Place of travel",
              "aggregationType": "NONE",
              "displayName": "Re-ACD Place of travel",
              "valueType": "ORGANISATION_UNIT",
              "optionSetValue": false
            },
            "programRule": {"id": "IrFmmQnkQVv"}
          },
          {
            "created": "2020-09-15T12:39:06.784",
            "lastUpdated": "2020-09-15T12:39:06.784",
            "id": "gtgHWfCV4UL",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-ACD Travel Period From",
              "id": "VEWB20kDYX3",
              "shortName": "Re-ACD Travel Period From",
              "aggregationType": "NONE",
              "displayName": "Re-ACD Travel Period From",
              "valueType": "DATE",
              "optionSetValue": false
            },
            "programRule": {"id": "IrFmmQnkQVv"}
          }
        ]
      },
      {
        "id": "ZSCIPuh0tef",
        "name": "mCBS MCR Hiding fields if not traveled in the past 4 weeks",
        "displayName":
            "mCBS MCR Hiding fields if not traveled in the past 4 weeks",
        "lastUpdated": "2020-09-20T08:23:37.900",
        "created": "2020-09-20T08:23:37.900",
        "condition": "A{Travel in the past 4 weeks} == 'No'",
        "programRuleActions": [
          {
            "created": "2020-09-20T08:23:37.750",
            "lastUpdated": "2020-09-20T08:23:37.750",
            "id": "ndzRSzHBt6b",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name": "Travel period (to)",
              "id": "IkX30fXj3cb",
              "shortName": "mCBS Travel period (to)",
              "generated": false,
              "displayName": "Travel period (to)",
              "valueType": "DATE",
              "optionSetValue": false
            },
            "programRule": {"id": "ZSCIPuh0tef"}
          },
          {
            "created": "2020-09-20T08:23:37.750",
            "lastUpdated": "2020-09-20T08:23:37.750",
            "id": "Xlm2qpWuCBl",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name": "Travel period (from)",
              "id": "ac59KOtlVW1",
              "shortName": "mCBS Travel period (from)",
              "generated": false,
              "displayName": "Travel period (from)",
              "valueType": "DATE",
              "optionSetValue": false
            },
            "programRule": {"id": "ZSCIPuh0tef"}
          },
          {
            "created": "2020-09-20T08:23:37.750",
            "lastUpdated": "2020-09-20T08:23:37.750",
            "id": "StO0PWWlX6e",
            "programRuleActionType": "HIDEFIELD",
            "trackedEntityAttribute": {
              "name": "Place of travel ",
              "id": "DZvnwu3pint",
              "shortName": "mCBS Place of travel ",
              "generated": false,
              "displayName": "Place of travel ",
              "valueType": "ORGANISATION_UNIT",
              "optionSetValue": false
            },
            "programRule": {"id": "ZSCIPuh0tef"}
          }
        ]
      },
      {
        "id": "bxTCpNFlUaK",
        "name": "Re-ACD Hiding fields if the case is imported",
        "displayName": "Re-ACD Hiding fields if the case is imported",
        "lastUpdated": "2020-09-15T12:41:12.288",
        "created": "2020-09-15T12:41:12.288",
        "condition": "#{Re-ACD Case classification} == 'Imported'",
        "programRuleActions": [
          {
            "created": "2020-09-15T12:41:12.145",
            "lastUpdated": "2020-09-15T12:41:12.145",
            "id": "bqVDe2i03qH",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name":
                  "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
              "id": "SFpdcuZMW6W",
              "shortName": "Re-known malaria Fever Case within same household",
              "aggregationType": "NONE",
              "displayName":
                  "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "Yes/No",
                "id": "WYVdsz7yuus",
                "options": [
                  {
                    "code": "Yes",
                    "name": "Yes",
                    "id": "OvWxPYgMpSA",
                    "sortOrder": 1
                  },
                  {
                    "code": "No",
                    "name": "No",
                    "id": "xXPM0UG0rsn",
                    "sortOrder": 2
                  }
                ]
              }
            },
            "programRule": {"id": "bxTCpNFlUaK"}
          },
          {
            "created": "2020-09-15T12:41:12.145",
            "lastUpdated": "2020-09-15T12:41:12.145",
            "id": "bj4gT7p2UYa",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name":
                  "Re-If local, current foci classification, follow provided job aids",
              "id": "GN8P1YHW5mY",
              "shortName": "Re-If local, current foci classification",
              "aggregationType": "NONE",
              "displayName":
                  "Re-If local, current foci classification, follow provided job aids",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "mCBS foci classification",
                "id": "rCMKujau63m",
                "options": [
                  {
                    "code": "Active",
                    "name": "Active",
                    "id": "EIZaimsLJhr",
                    "sortOrder": 1
                  },
                  {
                    "code": "Residue non active",
                    "name": "Residue non active",
                    "id": "OEjo0Y40acm",
                    "sortOrder": 2
                  },
                  {
                    "code": "Cleared",
                    "name": "Cleared",
                    "id": "YvQB0vxLNsc",
                    "sortOrder": 3
                  }
                ]
              }
            },
            "programRule": {"id": "bxTCpNFlUaK"}
          },
          {
            "created": "2020-09-15T12:41:12.145",
            "lastUpdated": "2020-09-15T12:41:12.145",
            "id": "UqijHaezChu",
            "programRuleActionType": "HIDEFIELD",
            "dataElement": {
              "name": "Re-Local case classification",
              "id": "MiIDFmt7MYg",
              "shortName": "Re-Local case classification",
              "aggregationType": "NONE",
              "displayName": "Re-Local case classification",
              "valueType": "TEXT",
              "optionSetValue": true,
              "optionSet": {
                "name": "mCBS Local case classification ",
                "id": "uRToOtz3mHQ",
                "options": [
                  {
                    "code": "Indigenous",
                    "name": "Indigenous",
                    "id": "VORTUj2KLC5",
                    "sortOrder": 1
                  },
                  {
                    "code": "Introduced",
                    "name": "Introduced",
                    "id": "N3Z9omb7XXt",
                    "sortOrder": 2
                  }
                ]
              }
            },
            "programRule": {"id": "bxTCpNFlUaK"}
          }
        ]
      }
    ],
    "programRuleVariables": [
      {
        "lastUpdated": "2020-09-15T12:26:56.350",
        "created": "2020-09-15T12:26:56.350",
        "name": "Re-ACD Travel To Date",
        "id": "OXrdn75EX4k",
        "displayName": "Re-ACD Travel To Date",
        "programRuleVariableSourceType": "DATAELEMENT_CURRENT_EVENT",
        "dataElement": {
          "name": "Re-ACD Travel Period To",
          "id": "UZIHjzdqppz",
          "shortName": "Re-ACD Travel Period To",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Travel Period To",
          "valueType": "DATE",
          "optionSetValue": false
        }
      },
      {
        "lastUpdated": "2020-09-15T12:21:25.267",
        "created": "2020-09-15T12:21:25.267",
        "name": "Re-ACD Case classification",
        "id": "XU4WpbTK3us",
        "displayName": "Re-ACD Case classification",
        "programRuleVariableSourceType": "DATAELEMENT_CURRENT_EVENT",
        "dataElement": {
          "name": "Re-ACD Case classification",
          "id": "ZVV4PtiYh7A",
          "shortName": "Re-ACD Case classification",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Case classification",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "mCBS Case classification",
            "id": "F9u147kfpdR",
            "options": [
              {
                "code": "Local",
                "name": "Local",
                "id": "iLrQEBgX7ni",
                "sortOrder": 1
              },
              {
                "code": "Imported",
                "name": "Imported",
                "id": "ZTwy5LOATsz",
                "sortOrder": 2
              }
            ]
          }
        }
      },
      {
        "lastUpdated": "2020-09-15T12:24:04.512",
        "created": "2020-09-15T12:24:04.512",
        "name": "Re-ACD Travel From date",
        "id": "YWeKgRGRM6w",
        "displayName": "Re-ACD Travel From date",
        "programRuleVariableSourceType": "DATAELEMENT_CURRENT_EVENT",
        "dataElement": {
          "name": "Re-ACD Travel Period From",
          "id": "VEWB20kDYX3",
          "shortName": "Re-ACD Travel Period From",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Travel Period From",
          "valueType": "DATE",
          "optionSetValue": false
        }
      },
      {
        "lastUpdated": "2020-09-20T08:18:12.171",
        "created": "2020-09-20T08:18:12.171",
        "name": "Travel period from",
        "id": "SutMSWis6S5",
        "displayName": "Travel period from",
        "programRuleVariableSourceType": "TEI_ATTRIBUTE",
        "trackedEntityAttribute": {
          "name": "Travel period (from)",
          "id": "ac59KOtlVW1",
          "shortName": "mCBS Travel period (from)",
          "generated": false,
          "displayName": "Travel period (from)",
          "valueType": "DATE",
          "optionSetValue": false
        }
      },
      {
        "lastUpdated": "2020-09-15T12:22:55.678",
        "created": "2020-09-15T12:22:55.678",
        "name": "Re-ACD Test",
        "id": "u3lIAKg3JPs",
        "displayName": "Re-ACD Test",
        "programRuleVariableSourceType": "DATAELEMENT_CURRENT_EVENT",
        "dataElement": {
          "name": "Re-ACD Tested",
          "id": "jJd1ieyyrrM",
          "shortName": "Re-ACD Tested",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Tested",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Yes/No",
            "id": "WYVdsz7yuus",
            "options": [
              {
                "code": "Yes",
                "name": "Yes",
                "id": "OvWxPYgMpSA",
                "sortOrder": 1
              },
              {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
            ]
          }
        }
      },
      {
        "lastUpdated": "2020-09-20T08:18:39.180",
        "created": "2020-09-20T08:18:39.180",
        "name": "Travel period to",
        "id": "QdyudGq9jnN",
        "displayName": "Travel period to",
        "programRuleVariableSourceType": "TEI_ATTRIBUTE",
        "trackedEntityAttribute": {
          "name": "Travel period (to)",
          "id": "IkX30fXj3cb",
          "shortName": "mCBS Travel period (to)",
          "generated": false,
          "displayName": "Travel period (to)",
          "valueType": "DATE",
          "optionSetValue": false
        }
      },
      {
        "lastUpdated": "2020-09-15T12:32:50.813",
        "created": "2020-09-15T12:32:50.813",
        "name": "Re-ACD Travel the in the past 4 weeks",
        "id": "ATLJBmK2wQ6",
        "displayName": "Re-ACD Travel the in the past 4 weeks",
        "programRuleVariableSourceType": "DATAELEMENT_CURRENT_EVENT",
        "dataElement": {
          "name": "Re-ACD Travel in the past 4 weeks",
          "id": "m68e2mT1f1Y",
          "shortName": "Re-ACD Travel in the past 4 weeks",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Travel in the past 4 weeks",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Yes/No",
            "id": "WYVdsz7yuus",
            "options": [
              {
                "code": "Yes",
                "name": "Yes",
                "id": "OvWxPYgMpSA",
                "sortOrder": 1
              },
              {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
            ]
          }
        }
      },
      {
        "lastUpdated": "2020-09-20T08:16:45.303",
        "created": "2020-09-20T08:16:45.303",
        "name": "Case classification",
        "id": "uugVmLF6Dt8",
        "displayName": "Case classification",
        "programRuleVariableSourceType": "TEI_ATTRIBUTE",
        "trackedEntityAttribute": {
          "name": "Case classification ",
          "id": "TzQcMwBOMKM",
          "shortName": "mCBS Case classification",
          "generated": false,
          "displayName": "Case classification ",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "code": "Case classification",
            "name": "Case classification",
            "id": "MFRsDTS2Qrm",
            "options": [
              {
                "code": "Local",
                "name": "Local",
                "id": "sENTCJfkwQI",
                "sortOrder": 1
              },
              {
                "code": "Imported",
                "name": "Imported",
                "id": "ksqneXZmHYn",
                "sortOrder": 2
              }
            ]
          }
        }
      },
      {
        "lastUpdated": "2020-09-20T08:19:39.991",
        "created": "2020-09-20T08:19:39.991",
        "name": "Travel in the past 4 weeks",
        "id": "cWFHiWAJ0Az",
        "displayName": "Travel in the past 4 weeks",
        "programRuleVariableSourceType": "TEI_ATTRIBUTE",
        "trackedEntityAttribute": {
          "name": "Travel in the past 4 weeks",
          "id": "fLtLZi9U9sp",
          "shortName": "mCBS Travel in the past 4 weeks",
          "generated": false,
          "displayName": "Travel in the past 4 weeks",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Yes/No",
            "id": "WYVdsz7yuus",
            "options": [
              {
                "code": "Yes",
                "name": "Yes",
                "id": "OvWxPYgMpSA",
                "sortOrder": 1
              },
              {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
            ]
          }
        }
      }
    ],
    "programRuleActions": [
      {
        "created": "2020-09-15T12:36:47.349",
        "lastUpdated": "2020-09-15T12:36:47.349",
        "id": "Dz4VgRQINfy",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-ACD Fever or History of fever in the past 3 days",
          "id": "Wd6shffAm5E",
          "shortName": "Re-ACD Fever or History of fever in the past 3 ",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Fever or History of fever in the past 3 days",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Yes/No",
            "id": "WYVdsz7yuus",
            "options": [
              {
                "code": "Yes",
                "name": "Yes",
                "id": "OvWxPYgMpSA",
                "sortOrder": 1
              },
              {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
            ]
          }
        },
        "programRule": {"id": "B50S6aoeIoT"}
      },
      {
        "created": "2020-09-15T12:36:47.349",
        "lastUpdated": "2020-09-15T12:36:47.349",
        "id": "HIaKwwv8Fri",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-ACD Test Result",
          "id": "uHUGHCcKAQB",
          "shortName": "Re-ACD Test Result",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Test Result",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Test Result (Positive/Negative)",
            "id": "aoVRajRJe9U",
            "options": [
              {
                "code": "Negative",
                "name": "Negative",
                "id": "u5zfYcJOAhn",
                "sortOrder": 1
              },
              {
                "code": "Positive",
                "name": "Positive",
                "id": "hhCLkio1gZg",
                "sortOrder": 2
              }
            ]
          }
        },
        "programRule": {"id": "B50S6aoeIoT"}
      },
      {
        "created": "2020-09-20T08:26:25.785",
        "lastUpdated": "2020-09-20T08:26:25.785",
        "id": "qLiaxXW18hA",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name": "If local, current foci classification",
          "id": "nXeOcMvi9Os",
          "shortName": "If local, current foci classification",
          "generated": false,
          "displayName": "If local, current foci classification",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "code": "If local, current foci classification",
            "name": "If local, current foci classification",
            "id": "jxNWsxR7RLh",
            "options": [
              {
                "code": "Active",
                "name": "Active",
                "id": "bsH8XMq0eXz",
                "sortOrder": 1
              },
              {
                "code": " Residue non active",
                "name": " Residue non active",
                "id": "jVR6KaitQly",
                "sortOrder": 2
              },
              {
                "code": "Cleared",
                "name": "Cleared",
                "id": "yhaE0Jzrojf",
                "sortOrder": 3
              }
            ]
          }
        },
        "programRule": {"id": "DD1gA7wtxnI"}
      },
      {
        "created": "2020-09-20T08:26:25.785",
        "lastUpdated": "2020-09-20T08:26:25.785",
        "id": "n3HIBVJGeBm",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name":
              "Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
          "id": "R3IQKrwOfH0",
          "shortName": "mCBS Any known malaria",
          "generated": false,
          "displayName":
              "Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
          "valueType": "BOOLEAN",
          "optionSetValue": false
        },
        "programRule": {"id": "DD1gA7wtxnI"}
      },
      {
        "created": "2020-09-20T08:26:25.785",
        "lastUpdated": "2020-09-20T08:26:25.785",
        "id": "KYSY9WBTZ6x",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name": "Local case classification ",
          "id": "uAnFHvxxITx",
          "shortName": "mCBS Local case classification ",
          "generated": false,
          "displayName": "Local case classification ",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "mCBS Local case classification ",
            "id": "uRToOtz3mHQ",
            "options": [
              {
                "code": "Indigenous",
                "name": "Indigenous",
                "id": "VORTUj2KLC5",
                "sortOrder": 1
              },
              {
                "code": "Introduced",
                "name": "Introduced",
                "id": "N3Z9omb7XXt",
                "sortOrder": 2
              }
            ]
          }
        },
        "programRule": {"id": "DD1gA7wtxnI"}
      },
      {
        "created": "2020-09-15T12:39:06.784",
        "lastUpdated": "2020-09-15T12:39:06.784",
        "id": "fd7nV6ncvzh",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-ACD Travel Period To",
          "id": "UZIHjzdqppz",
          "shortName": "Re-ACD Travel Period To",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Travel Period To",
          "valueType": "DATE",
          "optionSetValue": false
        },
        "programRule": {"id": "IrFmmQnkQVv"}
      },
      {
        "created": "2020-09-15T12:39:06.784",
        "lastUpdated": "2020-09-15T12:39:06.784",
        "id": "mywHUk5vUlW",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-ACD Place of travel",
          "id": "Nrmpp5Em3fQ",
          "shortName": "Re-ACD Place of travel",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Place of travel",
          "valueType": "ORGANISATION_UNIT",
          "optionSetValue": false
        },
        "programRule": {"id": "IrFmmQnkQVv"}
      },
      {
        "created": "2020-09-15T12:39:06.784",
        "lastUpdated": "2020-09-15T12:39:06.784",
        "id": "gtgHWfCV4UL",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-ACD Travel Period From",
          "id": "VEWB20kDYX3",
          "shortName": "Re-ACD Travel Period From",
          "aggregationType": "NONE",
          "displayName": "Re-ACD Travel Period From",
          "valueType": "DATE",
          "optionSetValue": false
        },
        "programRule": {"id": "IrFmmQnkQVv"}
      },
      {
        "created": "2020-09-20T08:23:37.750",
        "lastUpdated": "2020-09-20T08:23:37.750",
        "id": "ndzRSzHBt6b",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name": "Travel period (to)",
          "id": "IkX30fXj3cb",
          "shortName": "mCBS Travel period (to)",
          "generated": false,
          "displayName": "Travel period (to)",
          "valueType": "DATE",
          "optionSetValue": false
        },
        "programRule": {"id": "ZSCIPuh0tef"}
      },
      {
        "created": "2020-09-20T08:23:37.750",
        "lastUpdated": "2020-09-20T08:23:37.750",
        "id": "Xlm2qpWuCBl",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name": "Travel period (from)",
          "id": "ac59KOtlVW1",
          "shortName": "mCBS Travel period (from)",
          "generated": false,
          "displayName": "Travel period (from)",
          "valueType": "DATE",
          "optionSetValue": false
        },
        "programRule": {"id": "ZSCIPuh0tef"}
      },
      {
        "created": "2020-09-20T08:23:37.750",
        "lastUpdated": "2020-09-20T08:23:37.750",
        "id": "StO0PWWlX6e",
        "programRuleActionType": "HIDEFIELD",
        "trackedEntityAttribute": {
          "name": "Place of travel ",
          "id": "DZvnwu3pint",
          "shortName": "mCBS Place of travel ",
          "generated": false,
          "displayName": "Place of travel ",
          "valueType": "ORGANISATION_UNIT",
          "optionSetValue": false
        },
        "programRule": {"id": "ZSCIPuh0tef"}
      },
      {
        "created": "2020-09-15T12:41:12.145",
        "lastUpdated": "2020-09-15T12:41:12.145",
        "id": "bqVDe2i03qH",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name":
              "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
          "id": "SFpdcuZMW6W",
          "shortName": "Re-known malaria Fever Case within same household",
          "aggregationType": "NONE",
          "displayName":
              "Re-Any known malaria /Fever Case within the same household/neighborhood in the past 28 days",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "Yes/No",
            "id": "WYVdsz7yuus",
            "options": [
              {
                "code": "Yes",
                "name": "Yes",
                "id": "OvWxPYgMpSA",
                "sortOrder": 1
              },
              {"code": "No", "name": "No", "id": "xXPM0UG0rsn", "sortOrder": 2}
            ]
          }
        },
        "programRule": {"id": "bxTCpNFlUaK"}
      },
      {
        "created": "2020-09-15T12:41:12.145",
        "lastUpdated": "2020-09-15T12:41:12.145",
        "id": "bj4gT7p2UYa",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name":
              "Re-If local, current foci classification, follow provided job aids",
          "id": "GN8P1YHW5mY",
          "shortName": "Re-If local, current foci classification",
          "aggregationType": "NONE",
          "displayName":
              "Re-If local, current foci classification, follow provided job aids",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "mCBS foci classification",
            "id": "rCMKujau63m",
            "options": [
              {
                "code": "Active",
                "name": "Active",
                "id": "EIZaimsLJhr",
                "sortOrder": 1
              },
              {
                "code": "Residue non active",
                "name": "Residue non active",
                "id": "OEjo0Y40acm",
                "sortOrder": 2
              },
              {
                "code": "Cleared",
                "name": "Cleared",
                "id": "YvQB0vxLNsc",
                "sortOrder": 3
              }
            ]
          }
        },
        "programRule": {"id": "bxTCpNFlUaK"}
      },
      {
        "created": "2020-09-15T12:41:12.145",
        "lastUpdated": "2020-09-15T12:41:12.145",
        "id": "UqijHaezChu",
        "programRuleActionType": "HIDEFIELD",
        "dataElement": {
          "name": "Re-Local case classification",
          "id": "MiIDFmt7MYg",
          "shortName": "Re-Local case classification",
          "aggregationType": "NONE",
          "displayName": "Re-Local case classification",
          "valueType": "TEXT",
          "optionSetValue": true,
          "optionSet": {
            "name": "mCBS Local case classification ",
            "id": "uRToOtz3mHQ",
            "options": [
              {
                "code": "Indigenous",
                "name": "Indigenous",
                "id": "VORTUj2KLC5",
                "sortOrder": 1
              },
              {
                "code": "Introduced",
                "name": "Introduced",
                "id": "N3Z9omb7XXt",
                "sortOrder": 2
              }
            ]
          }
        },
        "programRule": {"id": "bxTCpNFlUaK"}
      }
    ],
    "optionSets": [
      {
        "created": "2020-03-04T04:08:29.235",
        "lastUpdated": "2020-05-12T09:13:51.204",
        "name": "Countries",
        "id": "ynHtyLDVeJO",
        "publicAccess": "--------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "fr", "value": "Pays"},
          {"property": "NAME", "locale": "ru", "value": "Страны"},
          {"property": "NAME", "locale": "pt", "value": "Países"},
          {"property": "NAME", "locale": "es", "value": "Paises"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "hGJnSu14S4H"},
          {"id": "jNHN0pOchoB"},
          {"id": "Bh4wWzctSjb"},
          {"id": "fjla1buVNJ1"},
          {"id": "hYLZM1WibDG"},
          {"id": "Vy2kZ2xdywD"},
          {"id": "SMRVOAezK6m"},
          {"id": "TAtDifm7RQ2"},
          {"id": "PJlpC0ulmxS"},
          {"id": "zbLeaXBzQ0r"},
          {"id": "ywRcbgzfJPh"},
          {"id": "LOaaG2lAIFa"},
          {"id": "t54DjoTR2p6"},
          {"id": "yW6IdVQov4u"},
          {"id": "m5ziJSjzRPE"},
          {"id": "ea6F8vmxRXr"},
          {"id": "kzAod6laMdd"},
          {"id": "iJ2Z9ipAEe6"},
          {"id": "Tk7FMD1MasS"},
          {"id": "ynsA4tpFPiu"},
          {"id": "agD66qYjXBj"},
          {"id": "cPIpkDRqE0s"},
          {"id": "ihkgYyvIpoJ"},
          {"id": "tbGOoDQGapm"},
          {"id": "ofZoh1cmVIS"},
          {"id": "TqHJcgfYYO7"},
          {"id": "cFC9TG5T6rk"},
          {"id": "JEvbk1d5kZz"},
          {"id": "W0yLTk0cm95"},
          {"id": "HwxSk7Bydgv"},
          {"id": "QUDg3f2Vykg"},
          {"id": "k7rCWMSHHnW"},
          {"id": "XPbtS9mdWu0"},
          {"id": "RhgmAKhAC5q"},
          {"id": "OxCmeYyS27P"},
          {"id": "ysELYlzPrdm"},
          {"id": "Tip7kcFjydR"},
          {"id": "UNQndlLuT6z"},
          {"id": "ZMRxkXvOSHd"},
          {"id": "hYinhh33Smb"},
          {"id": "e73WCSot5Kz"},
          {"id": "jg2D4zXeOEW"},
          {"id": "oEo4sOKVbxo"},
          {"id": "RIN4O3DOJ7i"},
          {"id": "iyOIO7u3rp2"},
          {"id": "IoNVJbgYCgK"},
          {"id": "cns3VhQOOLT"},
          {"id": "djBN4hznuVx"},
          {"id": "Ap6L7fXfDeR"},
          {"id": "ekNvWlcIqc6"},
          {"id": "gdaMM4iITdU"},
          {"id": "TULAmCgYERZ"},
          {"id": "df2Z1m4wiDH"},
          {"id": "gUv8NQnweWA"},
          {"id": "irKCzydHfvQ"},
          {"id": "z90AdvvHWFs"},
          {"id": "slZk3s6xPoM"},
          {"id": "hH0Hy1NEJLt"},
          {"id": "LdQF1sPxdxF"},
          {"id": "EbLJJJfvsfk"},
          {"id": "Dbq4nnM2YAX"},
          {"id": "j18ViLv3bH0"},
          {"id": "on9E0VYO7Fn"},
          {"id": "VEzuYX8hkAt"},
          {"id": "WAdbLIjOMui"},
          {"id": "HStdRZPlcpd"},
          {"id": "LqtYpN1esYr"},
          {"id": "D7X0HISqZFG"},
          {"id": "bC7LkeM89FC"},
          {"id": "qEznaEpFnJr"},
          {"id": "ZNlpMAULihV"},
          {"id": "bef2vVeR23P"},
          {"id": "t3xIkfi2H9B"},
          {"id": "zFR8DxViVCF"},
          {"id": "CVzjZYuAWYN"},
          {"id": "yUGs4f8ERRO"},
          {"id": "buoSIj3Vwra"},
          {"id": "tp6tO0mcWi3"},
          {"id": "kCQuehGwFao"},
          {"id": "ITLH48ZUffA"},
          {"id": "ACPpkQT2y2F"},
          {"id": "QZe0b0vBdRx"},
          {"id": "F7VjKLOSKYQ"},
          {"id": "O80pXVxnTv0"},
          {"id": "XgXpDOKZfIX"},
          {"id": "ic83mV0Np1K"},
          {"id": "PxDnUHCZFYV"},
          {"id": "F0bPny0RATH"},
          {"id": "zYa1MKY2G3d"},
          {"id": "lbhBF8S5JoR"},
          {"id": "okjtUpqkBY0"},
          {"id": "QlGDgVLB9Mg"},
          {"id": "yqF1sleXWu4"},
          {"id": "b226WlAQhQT"},
          {"id": "l2pI0kEQo1x"},
          {"id": "hgQ5KIZRzrq"},
          {"id": "UqDKVzW7N6x"},
          {"id": "UPgq5yBhzma"},
          {"id": "guqDJE0tEhz"},
          {"id": "ehSp3aJDOhB"},
          {"id": "M0vvlGGO2ET"},
          {"id": "oCqAUWB1AK0"},
          {"id": "snaU0ZUJ03A"},
          {"id": "Ls7DhgvN3M9"},
          {"id": "bvxdOvWV0Qt"},
          {"id": "kpEvOGtOaJa"},
          {"id": "PahOgLwCZMg"},
          {"id": "GgpJFlPRlXZ"},
          {"id": "GeUERumufaz"},
          {"id": "sHSgXweCFwT"},
          {"id": "c2gkADoIq0a"},
          {"id": "Iyxt9soGc5i"},
          {"id": "wW0cTJr4QvY"},
          {"id": "Dz0ikE8Opef"},
          {"id": "CxA2f0AZM2H"},
          {"id": "cCIXvPLzsUj"},
          {"id": "ysv73lzyfPU"},
          {"id": "W26NWlPaIJD"},
          {"id": "wrMAg1FeNEH"},
          {"id": "Rk3W9BRd1D6"},
          {"id": "FLWvmb7Fngv"},
          {"id": "hmmPhRwpYlN"},
          {"id": "PNloUnfVthd"},
          {"id": "khbm7vs5OVf"},
          {"id": "JBUNAoY2UCR"},
          {"id": "jX4Q0C4e5Wz"},
          {"id": "aWdKmnUbyq8"},
          {"id": "YFBUwHreFty"},
          {"id": "NgE7dxvafzN"},
          {"id": "Lcpj9JRPN6A"},
          {"id": "Ud37kwuqYOX"},
          {"id": "ol616QD7y9v"},
          {"id": "V9dlKIBeEt5"},
          {"id": "ZJKBOoWeZK8"},
          {"id": "TbqJLwX75MB"},
          {"id": "cz1jjVYazCU"},
          {"id": "vaAP0kIZoWc"},
          {"id": "oUZwMtRc9UZ"},
          {"id": "FTShlPn5hKZ"},
          {"id": "PXW5S4tsyeU"},
          {"id": "zSqkhuvMIJx"},
          {"id": "phk8e9YUIyk"},
          {"id": "Lr41AxFkOoQ"},
          {"id": "AZKUCGpgtzT"},
          {"id": "gr2CYy3Dr56"},
          {"id": "n8HXfqEC7qW"},
          {"id": "zJVqezCOVEw"},
          {"id": "goMYgrWwzxj"},
          {"id": "YMAWw8lGmVz"},
          {"id": "BFKxH53DgZ4"},
          {"id": "jpFFUofjPzL"},
          {"id": "Qodq6bOTBgk"},
          {"id": "HHpmrOG4Oah"},
          {"id": "o3FDUKEuK9I"},
          {"id": "CqUzE4oAeMo"},
          {"id": "G3wJAW7bEqO"},
          {"id": "XhVZiHLpMnJ"},
          {"id": "SFnJXKHtNPT"},
          {"id": "NbSAL47OfTk"},
          {"id": "G9i0iHpkYbp"},
          {"id": "isQUPKHcs6X"},
          {"id": "i6mNzSoi00T"},
          {"id": "fsojvbtJaQ9"},
          {"id": "CHVoLfGmFbt"},
          {"id": "DnKpeOCqfDu"},
          {"id": "abXMcNMfUHW"},
          {"id": "KCS77S1n8yE"},
          {"id": "Vd3efHrokOx"},
          {"id": "nuJCiz6sWMs"},
          {"id": "PSXaRzhAoO5"},
          {"id": "Z4UIfFiFuMC"},
          {"id": "y5Edd8OyiIS"},
          {"id": "JtLlBt8z3Th"},
          {"id": "u0Iy4qXUpGx"},
          {"id": "Hn8n03RTQoy"},
          {"id": "UH9iMU8RCbR"},
          {"id": "TgDFVQK8poQ"},
          {"id": "fJGUZnvCg0m"},
          {"id": "pMggNgUQ24t"},
          {"id": "YBnIVZiENSl"},
          {"id": "dyHaYgO8uRD"},
          {"id": "fDggEkf3s9Q"},
          {"id": "Vh7og15xjfI"},
          {"id": "XFtEiGSEM5K"},
          {"id": "TlWg479ykNG"},
          {"id": "AbZ1Ahy2uzF"},
          {"id": "Vx5yJqEFdiG"},
          {"id": "oJtdF4dJlKR"},
          {"id": "Fjs0ekdnQp4"},
          {"id": "cuBbK1kGxQG"},
          {"id": "CgCPhepq1T0"},
          {"id": "OiiQDTwRhiJ"},
          {"id": "kgx4yTXnCm5"},
          {"id": "ot9j1RhdTxJ"},
          {"id": "K2Z3GIjbpfy"},
          {"id": "IjeQQN6i6oB"},
          {"id": "mwQoRreFhS4"},
          {"id": "nslF0rp6DYP"},
          {"id": "m5Mzp8gH9SE"},
          {"id": "pGtXTzwNgYJ"},
          {"id": "wU06ZppIUrr"},
          {"id": "SVkuqbtbwkn"},
          {"id": "tgZNiP0av9R"},
          {"id": "C6mh8woRILR"},
          {"id": "XUAgsUvnd9D"},
          {"id": "ybi90nX7jIG"},
          {"id": "xscRY8jGm4I"},
          {"id": "nucHGYLnDym"},
          {"id": "AWCr3B2Ec6K"},
          {"id": "vVm2PrIRCZb"},
          {"id": "tmChdi1uORn"},
          {"id": "dsiiSBdkIOV"},
          {"id": "HvsdUX9XzqA"},
          {"id": "LSa01WRIEoa"},
          {"id": "BkyPw8ckTNY"},
          {"id": "TtTR0Yl2wu4"},
          {"id": "rWZk1zIRhxd"},
          {"id": "YiWILyGjKnW"},
          {"id": "z3ciloHD9PX"},
          {"id": "EfbDHbL0WVR"},
          {"id": "NgOETSb20pt"},
          {"id": "GHlYciOJcc3"},
          {"id": "lxBYLgAGHyI"},
          {"id": "ysx0MV7RW2X"},
          {"id": "E8gQhClNFbP"},
          {"id": "vpOUqs1VdKL"},
          {"id": "f5ZqqjsV2PJ"},
          {"id": "cpSzNk48yTR"},
          {"id": "ziovQhoHqXQ"},
          {"id": "PxkPTw9fbIk"},
          {"id": "RuqZKue3rFr"},
          {"id": "clThxUwFWOz"},
          {"id": "N1cS8AIDi1q"},
          {"id": "PDxzpx08WBj"},
          {"id": "QBbuw7ibNxz"},
          {"id": "slJul3ojjA4"},
          {"id": "rFyxYwKsUHn"},
          {"id": "J6NKBEYkEIX"},
          {"id": "MZtPirsiobx"},
          {"id": "zz44ZJwE4BC"},
          {"id": "aO1V8Km6tIa"},
          {"id": "alllxGOxa3E"},
          {"id": "yKhE8gOOm3t"},
          {"id": "MmfxULjuTXH"},
          {"id": "ctQxqa1n0Ki"},
          {"id": "NdVZXFSvX7t"},
          {"id": "oJ7nxbnJtlz"},
          {"id": "SJm6VUYbovd"},
          {"id": "YULlOdKf9DK"}
        ]
      },
      {
        "created": "2020-03-10T11:44:34.769",
        "lastUpdated": "2020-04-02T05:28:59.194",
        "name": "COVID-19 Health Outcome",
        "id": "qI4cs9ocBwn",
        "publicAccess": "--------",
        "version": 7,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {
            "property": "NAME",
            "locale": "fr",
            "value": "COVID-19 Etat de santé"
          },
          {
            "property": "NAME",
            "locale": "es",
            "value": "COVID-19 Pronostico al alta"
          }
        ],
        "userAccesses": [],
        "options": [
          {"id": "dUeRcF2cApV"},
          {"id": "QyRA3pEnRU2"},
          {"id": "RCT079wdeKT"},
          {"id": "Lu7rlfnDHUJ"},
          {"id": "xBoo6HyaYcd"},
          {"id": "bYt4why1tL3"}
        ]
      },
      {
        "code": "Districts",
        "created": "2020-05-08T08:56:23.082",
        "lastUpdated": "2020-05-08T10:15:13.013",
        "name": "Districts",
        "id": "JL7b11gQhGW",
        "publicAccess": "rw------",
        "version": 184,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "M5zQapPyTZI"},
        "userGroupAccesses": [],
        "attributeValues": [],
        "translations": [],
        "userAccesses": [],
        "options": [
          {"id": "tCWHQxrQnnK"},
          {"id": "TVrpHgqKkzG"},
          {"id": "DexNfCb9duJ"},
          {"id": "eSkqAArE4nL"},
          {"id": "DXSt696DEks"},
          {"id": "i57dim3wSUt"},
          {"id": "eFInEE1uMfX"},
          {"id": "x6VvcfxdEMg"},
          {"id": "ZqT7TndYXYl"},
          {"id": "fvf9ZY1N3eC"},
          {"id": "K7IxYRxEOxF"},
          {"id": "cgox33jbTpM"},
          {"id": "XhciopXY9rq"},
          {"id": "afPoHF7C152"},
          {"id": "xyfgA3Cg3t7"},
          {"id": "B1LbADVJEfj"},
          {"id": "P9kFkDS3q1K"},
          {"id": "VpRx78SWkdR"},
          {"id": "aobK0uHZ81u"},
          {"id": "gelvkmTWXNS"},
          {"id": "NrnvL1q0R0s"},
          {"id": "auVFAV8jevY"},
          {"id": "ORhEgSnm1TV"},
          {"id": "OgzystO1b1i"},
          {"id": "pNT37i8QxrD"},
          {"id": "fU32V7P0MDe"},
          {"id": "M2iWYTY2bot"},
          {"id": "g23DD7qb3wE"},
          {"id": "kDeWCSalcoH"},
          {"id": "gx7JbgVusvB"},
          {"id": "zBXTOLSwDhZ"},
          {"id": "FaZUmvEze4F"},
          {"id": "IGlKvfSdipu"},
          {"id": "GKzofruEv4H"},
          {"id": "iyfqu77Xz4g"},
          {"id": "zS8tZvUd1a9"},
          {"id": "yIYXZSBzVgS"},
          {"id": "oEuKZTrvIGf"},
          {"id": "AatE4RYwcgk"},
          {"id": "Wn8KaRR45yG"},
          {"id": "oGN0kEatNRj"},
          {"id": "rTrGlhf8hYM"},
          {"id": "sbyMOa0CIoJ"},
          {"id": "IdJzo4iRq38"},
          {"id": "igUWRuKiaXn"},
          {"id": "MLGcq2wFYWw"},
          {"id": "Y9Vb7TSj9BT"},
          {"id": "QyWa4pETaU3"},
          {"id": "inxHKcolX4l"},
          {"id": "kFuzE6ZByUs"},
          {"id": "KyZXTWT0RVh"},
          {"id": "syrhHepHtrK"},
          {"id": "UfewRgmsop4"},
          {"id": "cANViUzl0Qi"},
          {"id": "UDWhTTXN2gb"},
          {"id": "d98XxwcbxHb"},
          {"id": "cBTzTJGWH7u"},
          {"id": "wcQeEmgGHRE"},
          {"id": "gnwLddkDHKJ"},
          {"id": "wHceuS7tuhh"},
          {"id": "jIlDq5dNzYF"},
          {"id": "RApnYt4YZ0L"},
          {"id": "e32AcxEcOzW"},
          {"id": "bPEgNBwhE99"},
          {"id": "cvlQK284DNX"},
          {"id": "WYZNRrn9DFg"},
          {"id": "ZB1ftV9mOb9"},
          {"id": "tGSasRMHHeu"},
          {"id": "MkJIIUnll0h"},
          {"id": "rtuGboXzhZC"},
          {"id": "Du9lJzKTfpS"},
          {"id": "l2zTNOZxRPh"},
          {"id": "THcqFjuboH3"},
          {"id": "Sjq1NmN1Rrq"},
          {"id": "lQxnPpq6SUi"},
          {"id": "rA4RAAQ4Hv5"},
          {"id": "uoE8oJEzILJ"},
          {"id": "Asz3END7CXR"},
          {"id": "XYnQayNkFZs"},
          {"id": "Vt2ny9PxtkM"},
          {"id": "E1bZojipfNJ"},
          {"id": "IXrugLctmKQ"},
          {"id": "bASSbIgEe4x"},
          {"id": "SL750FZYwcY"},
          {"id": "WEXELKdak4U"},
          {"id": "qMMvzWo1IEw"},
          {"id": "YxTyjt5lXNr"},
          {"id": "fhXOwLVErCw"},
          {"id": "Js5DbDhHOnW"},
          {"id": "j5BfukJaziO"},
          {"id": "mvyU2uZfWWI"},
          {"id": "HmXDfXLTzfx"},
          {"id": "ZGHWG8kQoBc"},
          {"id": "QiUtiQdVqgA"},
          {"id": "WOvfhW56gTN"},
          {"id": "muKrOqHLBe2"},
          {"id": "DWR7YAj5L0m"},
          {"id": "rCx6HiNAhZC"},
          {"id": "zqCRVpdaCIa"},
          {"id": "C1BQkGjyUhF"},
          {"id": "fCsWZ8ZGxJt"},
          {"id": "rXYDtlXxNhn"},
          {"id": "KcS11k7jrHN"},
          {"id": "wZIqJ50iXVT"},
          {"id": "lb2GJ2KtZKR"},
          {"id": "m5eefZsm9wu"},
          {"id": "G9W2sAGaJoN"},
          {"id": "oV5p3pUywcy"},
          {"id": "Wp5P9QKEWRG"},
          {"id": "QuYsPacaY6g"},
          {"id": "QYlISfSXK7Y"},
          {"id": "r2zDM78l7hf"},
          {"id": "WQlBVsSFnDM"},
          {"id": "RHMP5ZkoQlN"},
          {"id": "SoQMoWhVoau"},
          {"id": "nrjDFwhogGs"},
          {"id": "ij41odbY52V"},
          {"id": "Q8WDvxgIse4"},
          {"id": "qmOuQqqmY4v"},
          {"id": "pqq08DnX6Pf"},
          {"id": "FOFdArU91Dq"},
          {"id": "wnunoEJMSzd"},
          {"id": "VtcIkkcyBH3"},
          {"id": "MMML76qCxSP"},
          {"id": "nvckffdw4Cy"},
          {"id": "suFZwUqdchl"},
          {"id": "USr5WGNHfdT"},
          {"id": "Ftti8BUzNuY"},
          {"id": "ELNn6sLBsOn"},
          {"id": "BYcjprF0D8a"},
          {"id": "qCqor5MY41i"},
          {"id": "P5GwSDjW22H"},
          {"id": "HYG7H1VWLvr"},
          {"id": "bJSYxRJF0GT"},
          {"id": "VxYLUNS0xSp"},
          {"id": "YnxaXZ1W04F"},
          {"id": "NgxuQqZZrNC"},
          {"id": "zRdnPDjR1EP"},
          {"id": "BpmywBIGTtS"},
          {"id": "Or6pNg5OJpI"},
          {"id": "uCiiYKqSnlZ"},
          {"id": "DmIxbQfHN3x"},
          {"id": "YOicJufCIWW"},
          {"id": "dDIuG1lHvEg"},
          {"id": "bai5Orlg2ab"},
          {"id": "Onij5E1oTYB"},
          {"id": "t53jJxxATAc"},
          {"id": "HmljaxHHhZl"},
          {"id": "pHt3qLhl9r2"},
          {"id": "MPRkbFQtTe5"},
          {"id": "H5e7XmUFIxi"},
          {"id": "qArjSriP1DH"},
          {"id": "UVBWomXLJuu"},
          {"id": "WpZouMixi7H"},
          {"id": "GpRDosaaDyG"},
          {"id": "rezzpwsAaPM"},
          {"id": "vofgm6oSlRS"},
          {"id": "muVTh3wo6XY"},
          {"id": "fqRxV4Listj"},
          {"id": "pnKVAMZJkoF"},
          {"id": "TkQomsMsMCU"},
          {"id": "rCNw5PTqF0T"},
          {"id": "fSvbcq8mUIZ"},
          {"id": "u96R4yxmO8t"},
          {"id": "S8iboas384a"},
          {"id": "Xc9OExeveIP"},
          {"id": "PRepJKETUYy"},
          {"id": "Ne1NFMlohjE"},
          {"id": "MlEDsMlkO5V"},
          {"id": "rV9XUfYCXSi"},
          {"id": "KwXCmW2DuCV"},
          {"id": "fCGodwRPFBW"},
          {"id": "QzCMJSqmZL7"},
          {"id": "asjfbAIVsb3"},
          {"id": "abLWbFZ4XVh"},
          {"id": "gOFk5uKrjp5"},
          {"id": "Lv2p3OGRVCN"},
          {"id": "kdVMGfsHu0i"},
          {"id": "UiKMr8YK4Qp"},
          {"id": "dyiuN1ifLyc"},
          {"id": "rY9caFctJFl"},
          {"id": "FVKphEl34kV"},
          {"id": "CJAuY5gdygu"},
          {"id": "h74KQwn3c0k"}
        ]
      },
      {
        "code": "jinsi",
        "created": "2020-05-05T11:07:42.763",
        "lastUpdated": "2020-05-05T11:08:19.904",
        "name": "Jinsi",
        "id": "R54HWqYAdzJ",
        "publicAccess": "rw------",
        "version": 2,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "M5zQapPyTZI"},
        "userGroupAccesses": [],
        "attributeValues": [],
        "translations": [],
        "userAccesses": [],
        "options": [
          {"id": "Aq2Xz1xtHQu"},
          {"id": "oAUijQu4cMO"}
        ]
      },
      {
        "code": "NdioHapana",
        "created": "2020-05-18T18:46:46.674",
        "lastUpdated": "2020-05-18T18:47:29.795",
        "name": "Ndio/Hapana",
        "id": "DFQjwshmXeF",
        "publicAccess": "rw------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "M5zQapPyTZI"},
        "userGroupAccesses": [],
        "attributeValues": [],
        "translations": [],
        "userAccesses": [],
        "options": [
          {"id": "e7dPfLnCfNT"},
          {"id": "dwTqBQ253j1"}
        ]
      },
      {
        "created": "2020-03-04T04:15:13.570",
        "lastUpdated": "2020-04-02T05:28:59.195",
        "name": "Pregnancy Trimester",
        "id": "kQ35kc6sUal",
        "publicAccess": "--------",
        "version": 4,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "es", "value": "Trimestre Embarazo"},
          {
            "property": "NAME",
            "locale": "fr",
            "value": "Trimestre de la grossesse"
          }
        ],
        "userAccesses": [],
        "options": [
          {"id": "I4zfZxP6fSu"},
          {"id": "zYSedxtTSrw"},
          {"id": "Mh4zgThlTVm"}
        ]
      },
      {
        "code": "regions",
        "created": "2020-05-08T08:07:49.819",
        "lastUpdated": "2020-05-08T19:26:27.946",
        "name": "Regions",
        "id": "oKeXxX4zrdT",
        "publicAccess": "rw------",
        "version": 26,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "M5zQapPyTZI"},
        "userGroupAccesses": [],
        "attributeValues": [],
        "translations": [],
        "userAccesses": [],
        "options": [
          {"id": "jLFVh5QFFDD"},
          {"id": "aW35CjWD2FL"},
          {"id": "taNwSSf6RHI"},
          {"id": "rn1d4SXDEJ1"},
          {"id": "KnDaVAsJpFu"},
          {"id": "EHjab29nEuD"},
          {"id": "PocJcVEtZVo"},
          {"id": "GCDlkVUR64z"},
          {"id": "B4p4DPK3DwZ"},
          {"id": "w7H40iTC0YL"},
          {"id": "AoaihnBXUFo"},
          {"id": "f76W1yWQ1E0"},
          {"id": "V8WQKBUt3Rb"},
          {"id": "Emg6CCFHK7T"},
          {"id": "X97yNychZqB"},
          {"id": "vByPNQxKC6A"},
          {"id": "IIxWCnDbXaG"},
          {"id": "gvhR2J16bwz"},
          {"id": "mn4aQtVlKhS"},
          {"id": "VjrNHlmBQ1b"},
          {"id": "j6DpHKvw5Nx"},
          {"id": "S0Bx5lqgIvf"},
          {"id": "DPhnC6PayjJ"},
          {"id": "uuG0xTs25hr"},
          {"id": "tBWjHDBhI2E"},
          {"id": "wBV5KWvOa1Q"}
        ]
      },
      {
        "created": "2020-03-17T20:40:44.603",
        "lastUpdated": "2020-04-02T05:28:59.195",
        "name": "Relationship",
        "id": "WNmlbr0eduW",
        "publicAccess": "--------",
        "version": 8,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "ru", "value": "Родство"},
          {"property": "NAME", "locale": "pt", "value": "Relacionamento"},
          {"property": "NAME", "locale": "fr", "value": "Relation"},
          {"property": "NAME", "locale": "es", "value": "Relacion"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "QQW5LNrqmHO"},
          {"id": "VGQ6kt134cE"},
          {"id": "HTeGFWzGISt"},
          {"id": "Z9SyDP75ska"},
          {"id": "MJdc8NZXiVk"},
          {"id": "UQ5n9G7fa6n"},
          {"id": "uvxvP0atluZ"}
        ]
      },
      {
        "created": "2012-05-02T19:21:48.653",
        "lastUpdated": "2020-04-24T04:41:39.699",
        "name": "Sex",
        "id": "WDUwjiW2rGH",
        "publicAccess": "rw------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "M5zQapPyTZI"},
        "userGroupAccesses": [],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "de", "value": "Sexo"},
          {"property": "NAME", "locale": "es", "value": "Sexo"},
          {"property": "NAME", "locale": "pt", "value": "Sexo"},
          {"property": "NAME", "locale": "ru", "value": "Пол"},
          {"property": "NAME", "locale": "uz@Latn", "value": "Jinsi"},
          {"property": "NAME", "locale": "uz@Cyrl", "value": "Жинси"},
          {"property": "NAME", "locale": "fr", "value": "Sexe"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "Ii4IxCLWEFn"},
          {"id": "FKKrOBBFgs1"}
        ]
      },
      {
        "created": "2016-12-12T14:38:09.522",
        "lastUpdated": "2020-04-02T05:28:59.196",
        "name": "Specimen Type",
        "id": "pZi1AFMh9wd",
        "publicAccess": "--------",
        "version": 13,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "es", "value": "Tipo de muestra"},
          {"property": "NAME", "locale": "fr", "value": "Type de prélèvement"},
          {"property": "NAME", "locale": "ru", "value": "Тип образца"},
          {"property": "NAME", "locale": "pt", "value": "Tipo de amostra"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "yz1yaLuimVH"},
          {"id": "SafgFrXvTbO"},
          {"id": "Pye41T8qwmP"},
          {"id": "m7sTLqF1FoO"},
          {"id": "nfQXW97I75W"},
          {"id": "irpAtoaXdL0"},
          {"id": "wDLUHhCLhIS"},
          {"id": "VqiIk2PnjxY"},
          {"id": "Wq1bg0tqK9b"},
          {"id": "SIgTQDQoS1B"},
          {"id": "fsaZNChxdfd"}
        ]
      },
      {
        "created": "2020-03-04T02:57:52.051",
        "lastUpdated": "2020-04-02T05:28:59.196",
        "name": "Test Reason",
        "id": "XWz1NrfDcY0",
        "publicAccess": "--------",
        "version": 8,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "fr", "value": "Raison de test"},
          {"property": "NAME", "locale": "pt", "value": "Motivos do Teste"},
          {
            "property": "NAME",
            "locale": "es",
            "value": "Motivo de realizacion de la prueba"
          },
          {
            "property": "NAME",
            "locale": "ru",
            "value": "Причина проведения теста"
          }
        ],
        "userAccesses": [],
        "options": [
          {"id": "XH1znvVJn6M"},
          {"id": "MLiqX10HtXc"},
          {"id": "KwCvwW9NbPJ"},
          {"id": "QsoO7SWk4TF"},
          {"id": "n98rt3zMm4i"},
          {"id": "gS3q9iuIQ34"}
        ]
      },
      {
        "created": "2016-12-12T14:38:09.522",
        "lastUpdated": "2020-04-02T05:28:59.196",
        "name": "Test Result",
        "id": "dsgBmIZ0Yrq",
        "publicAccess": "--------",
        "version": 6,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "ru", "value": "Результат теста"},
          {"property": "NAME", "locale": "pt", "value": "Resultado do teste"},
          {"property": "NAME", "locale": "fr", "value": "Résultats des tests"},
          {
            "property": "NAME",
            "locale": "es",
            "value": "Resultado de la Prueba"
          }
        ],
        "userAccesses": [],
        "options": [
          {"id": "B44lkxTWbGO"},
          {"id": "ljClr1z2aE7"},
          {"id": "LKbwTJwocOk"},
          {"id": "MkeWrqeqZXL"},
          {"id": "fPV0gQ8ds6D"},
          {"id": "YV3jCZlvwZe"}
        ]
      },
      {
        "code": "033",
        "created": "2017-05-03T10:14:00.740",
        "lastUpdated": "2020-04-02T05:28:59.196",
        "name": "Test Type",
        "id": "wKos8PfhY44",
        "publicAccess": "--------",
        "version": 6,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "es", "value": "Tipo de Prueba"},
          {"property": "NAME", "locale": "pt", "value": "Tipo de Teste"},
          {"property": "NAME", "locale": "ru", "value": "Тип теста"},
          {"property": "NAME", "locale": "fr", "value": "Type de test"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "JdlDoOIaSSd"},
          {"id": "kwf8PBdlpMy"},
          {"id": "IHPBPVZISJK"},
          {"id": "FSGWVIIjZUS"}
        ]
      },
      {
        "code": "VACC_INFO_SOURCES",
        "created": "2017-05-03T07:33:45.407",
        "lastUpdated": "2020-03-26T10:20:22.412",
        "name": "Vaccination information sources",
        "id": "mB5sCZmeu06",
        "publicAccess": "--------",
        "version": 2,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "wnaAI6khQp1"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [],
        "userAccesses": [],
        "options": [
          {"id": "Hzw29EWAl2m"},
          {"id": "RwQpocmAPUr"},
          {"id": "M8ehCcWj8FB"}
        ]
      },
      {
        "code": "VACC_DOSES",
        "created": "2017-05-03T07:30:28.080",
        "lastUpdated": "2020-04-02T05:28:59.197",
        "name": "Vaccine doses",
        "id": "HxfU5BTvkhl",
        "publicAccess": "--------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "es", "value": "Dosis Vacuna"},
          {"property": "NAME", "locale": "fr", "value": "Doses de vaccin"},
          {"property": "NAME", "locale": "pt", "value": "Doses de vacina"},
          {"property": "NAME", "locale": "ru", "value": "Дозы вакцины"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "Gm6IceFjeg9"},
          {"id": "hvJ1wYKrJBD"},
          {"id": "F0bkECk8hNZ"},
          {"id": "P9HTz2ozWx1"},
          {"id": "IOQZiJjxjIx"},
          {"id": "YBRUrC7aWNw"},
          {"id": "tTnnFWmbioV"},
          {"id": "shiw72UmVbo"}
        ]
      },
      {
        "code": "VACC_TYPES",
        "created": "2017-05-03T07:28:11.885",
        "lastUpdated": "2020-04-02T05:28:59.197",
        "name": "Vaccine types",
        "id": "JMuLtUFmPZ5",
        "publicAccess": "--------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "fr", "value": "Types de vaccin"},
          {"property": "NAME", "locale": "es", "value": "Tipos de Vacuna"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "OC3ViIiPRGE"},
          {"id": "Hql1mmOgqTo"},
          {"id": "Xd5q0EjmfHt"},
          {"id": "YzJIAA7Pxak"}
        ]
      },
      {
        "created": "2017-05-02T18:34:58.765",
        "lastUpdated": "2020-04-02T05:28:59.197",
        "name": "Yes/No/Unknown",
        "id": "L6eMZDJkCwX",
        "publicAccess": "--------",
        "version": 3,
        "valueType": "TEXT",
        "lastUpdatedBy": {"id": "M5zQapPyTZI"},
        "user": {"id": "vUeLeQMSwhN"},
        "userGroupAccesses": [
          {
            "access": "rw------",
            "userGroupUid": "w4iJeNKy9br",
            "displayName": "COVID19 admin",
            "id": "w4iJeNKy9br"
          },
          {
            "access": "r-------",
            "userGroupUid": "DoYehxUvmwT",
            "displayName": "COVID19 access",
            "id": "DoYehxUvmwT"
          },
          {
            "access": "r-------",
            "userGroupUid": "k8Fk0kuhOeK",
            "displayName": "COVID19 data capture",
            "id": "k8Fk0kuhOeK"
          }
        ],
        "attributeValues": [],
        "translations": [
          {"property": "NAME", "locale": "pt", "value": "Sim/Não/Desconhecido"},
          {"property": "NAME", "locale": "es", "value": "Si/No/Desconocido"},
          {"property": "NAME", "locale": "fr", "value": "Oui/Non/Inconnu"},
          {"property": "NAME", "locale": "ru", "value": "Да/Нет/Неизвестно"}
        ],
        "userAccesses": [],
        "options": [
          {"id": "x9yVKkv9koc"},
          {"id": "R98tI2c6rF5"},
          {"id": "pqxvAQU1z9W"}
        ]
      }
    ]
  };

  final dynamic expectedOutput = {
    'eventsData': testSampleJson['eventsData'],
    'dataElements': testSampleJson['dataElements'],
    'programRules': testSampleJson['programRules'],
    'programRuleVariables': testSampleJson['programRuleVariables'],
    'optionSets': testSampleJson['optionSets']
  };

  final dynamic expectedDataValue = testSampleJson['eventsData']['dataValue'];
  final executeProgramRuleOnTest = ProgramRuleExecution().executeProgramRule(
      testSampleJson['eventsData'],
      testSampleJson['dataElements'],
      testSampleJson['programRules'],
      testSampleJson['programRuleVariables'],
      testSampleJson['optionSets']);

  test("should execute program rule", () {
    expect(executeProgramRuleOnTest, expectedDataValue);
  });
}

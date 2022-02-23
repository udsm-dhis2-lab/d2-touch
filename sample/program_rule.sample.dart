final Map<String, dynamic> sampleProgramRules = {
  "programRules": [
    {
      "lastUpdated": "2017-05-23T00:29:24.523",
      "created": "2015-09-14T21:17:40.841",
      "name": "Ask for comment for low apgar",
      "id": "NAgjOfWMXg6",
      "condition":
          "#{apgarscore} >= 0 && #{apgarscore} < 4 && #{apgarcomment} == ''",
      "displayName": "Ask for comment for low apgar",
      "description":
          "Show warrning if Apgar is between 0 and 4 and there is no comment provided.",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "created": "2015-09-14T21:17:41.033",
          "lastUpdated": "2017-05-23T00:29:24.467",
          "id": "v434s5YPDcP",
          "programRuleActionType": "SHOWWARNING",
          "evaluationTime": "ALWAYS",
          "content":
              "It is suggested that an explanation is provided when the Apgar score is below 4",
          "displayContent":
              "It is suggested that an explanation is provided when the Apgar score is below 4",
          "dataElement": {"id": "H6uSAMO5WLD"},
          "programRule": {"id": "NAgjOfWMXg6"}
        }
      ]
    },
    {
      "lastUpdated": "2017-05-23T00:29:24.528",
      "created": "2015-09-14T22:20:33.429",
      "name": "Demand comment if apgar is under zero",
      "id": "tTPMkizzUZg",
      "condition": "#{apgarscore} <0 && #{apgarcomment} == ''",
      "displayName": "Demand comment if apgar is under zero",
      "description":
          "If Apgar is provided as being under zero and there is no comment for the anomaly, show an error message.",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "created": "2015-09-14T22:20:33.543",
          "lastUpdated": "2017-05-23T00:29:24.466",
          "id": "t944GaMzNbs",
          "programRuleActionType": "SHOWERROR",
          "evaluationTime": "ALWAYS",
          "content":
              "If the apgar score is below zero, an explanation must be provided.",
          "displayContent":
              "If the apgar score is below zero, an explanation must be provided.",
          "dataElement": {"id": "a3kGcGDCuk6"},
          "programRule": {"id": "tTPMkizzUZg"}
        }
      ]
    },
    {
      "lastUpdated": "2017-05-23T00:29:24.529",
      "created": "2015-08-07T18:41:55.082",
      "name": "Hide Apgar comment if score > 7",
      "id": "ppdTpuQC7Q5",
      "condition": "#{apgarscore} > 7",
      "displayName": "Hide Apgar comment if score > 7",
      "description": "Hide Apgar comment if score > 7",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "created": "2015-08-07T18:41:55.210",
          "lastUpdated": "2017-05-23T00:29:24.468",
          "id": "iwGAWKvStTt",
          "programRuleActionType": "HIDEFIELD",
          "evaluationTime": "ALWAYS",
          "dataElement": {"id": "H6uSAMO5WLD"},
          "programRule": {"id": "ppdTpuQC7Q5"}
        }
      ]
    },
    {
      "name": "Assign Last name if gender is female",
      "id": "gmpBeDbY05Z",
      "condition": "A{genderattribute}  == 'Female'",
      "displayName": "Assign Last name if gender is female",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "lastUpdated": "2022-02-16T18:02:56.724",
          "id": "ulPyDVRD6QN",
          "created": "2022-02-16T18:02:56.724",
          "data": "Last Name",
          "externalAccess": false,
          "programRuleActionType": "ASSIGN",
          "evaluationTime": "ALWAYS",
          "favorite": false,
          "access": {
            "read": true,
            "update": true,
            "externalize": true,
            "delete": true,
            "write": true,
            "manage": true
          },
          "trackedEntityAttribute": {"id": "zDhUuAYrxNC"},
          "programRule": {"id": "gmpBeDbY05Z"},
          "lastUpdatedBy": {
            "displayName": "Tom Wakiki",
            "id": "GOLswS44mh8",
            "username": "system"
          },
          "favorites": [],
          "evaluationEnvironments": ["WEB", "ANDROID"],
          "translations": [],
          "userGroupAccesses": [],
          "attributeValues": [],
          "userAccesses": []
        }
      ]
    }
  ]
};

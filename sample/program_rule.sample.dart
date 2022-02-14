final Map<String, dynamic> sampleProgramRules = {
  "pager": {"page": 1, "pageCount": 1, "total": 3, "pageSize": 50},
  "programRules": [
    {
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
          "lastUpdated": "2017-05-23T00:29:24.467",
          "id": "v434s5YPDcP",
          "created": "2015-09-14T21:17:41.033",
          "content":
              "It is suggested that an explanation is provided when the Apgar score is below 4",
          "externalAccess": false,
          "displayContent":
              "It is suggested that an explanation is provided when the Apgar score is below 4",
          "programRuleActionType": "SHOWWARNING",
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
          "programRule": {"id": "NAgjOfWMXg6"},
          "lastUpdatedBy": {
            "displayName": "John Traore",
            "id": "xE7jOejl9FI",
            "username": "admin"
          },
          "dataElement": {"id": "H6uSAMO5WLD"},
          "favorites": [],
          "evaluationEnvironments": ["WEB", "ANDROID"],
          "translations": [],
          "userGroupAccesses": [],
          "attributeValues": [],
          "userAccesses": []
        }
      ]
    },
    {
      "name": "Demand comment if apgar is under zero",
      "id": "tTPMkizzUZg",
      "condition": "#{apgarscore} <0 && #{apgarcomment} == ''",
      "displayName": "Demand comment if apgar is under zero",
      "description":
          "If Apgar is provided as being under zero and there is no comment for the anomaly, show an error message.",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "lastUpdated": "2017-05-23T00:29:24.466",
          "id": "t944GaMzNbs",
          "created": "2015-09-14T22:20:33.543",
          "content":
              "If the apgar score is below zero, an explanation must be provided.",
          "externalAccess": false,
          "displayContent":
              "If the apgar score is below zero, an explanation must be provided.",
          "programRuleActionType": "SHOWERROR",
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
          "programRule": {"id": "tTPMkizzUZg"},
          "lastUpdatedBy": {
            "displayName": "John Traore",
            "id": "xE7jOejl9FI",
            "username": "admin"
          },
          "dataElement": {"id": "a3kGcGDCuk6"},
          "favorites": [],
          "evaluationEnvironments": ["WEB", "ANDROID"],
          "translations": [],
          "userGroupAccesses": [],
          "attributeValues": [],
          "userAccesses": []
        }
      ]
    },
    {
      "name": "Hide Apgar comment if score > 7",
      "id": "ppdTpuQC7Q5",
      "condition": "#{apgarscore} > 7",
      "displayName": "Hide Apgar comment if score > 7",
      "description": "Hide Apgar comment if score > 7",
      "program": {"id": "IpHINAT79UW"},
      "programRuleActions": [
        {
          "lastUpdated": "2017-05-23T00:29:24.468",
          "id": "iwGAWKvStTt",
          "created": "2015-08-07T18:41:55.210",
          "externalAccess": false,
          "programRuleActionType": "HIDEFIELD",
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
          "programRule": {"id": "ppdTpuQC7Q5"},
          "lastUpdatedBy": {
            "displayName": "John Traore",
            "id": "xE7jOejl9FI",
            "username": "admin"
          },
          "dataElement": {"id": "H6uSAMO5WLD"},
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

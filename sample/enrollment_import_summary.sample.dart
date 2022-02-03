final Map<Object, dynamic> sampleEnrollmentImportSummary = {
  "httpStatus": "Conflict",
  "httpStatusCode": 409,
  "status": "ERROR",
  "message": "An error occurred, please check import summary.",
  "response": {
    "responseType": "ImportSummaries",
    "status": "ERROR",
    "imported": 0,
    "updated": 0,
    "deleted": 0,
    "ignored": 2,
    "importOptions": {
      "idSchemes": {},
      "dryRun": false,
      "async": false,
      "importStrategy": "CREATE_AND_UPDATE",
      "mergeMode": "REPLACE",
      "reportMode": "FULL",
      "skipExistingCheck": false,
      "sharing": false,
      "skipNotifications": false,
      "skipAudit": false,
      "datasetAllowsPeriods": false,
      "strictPeriods": false,
      "strictDataElements": false,
      "strictCategoryOptionCombos": false,
      "strictAttributeOptionCombos": false,
      "strictOrganisationUnits": false,
      "requireCategoryOptionCombo": false,
      "requireAttributeOptionCombo": false,
      "skipPatternValidation": false,
      "ignoreEmptyCollection": false,
      "force": false,
      "firstRowIsHeader": true,
      "skipLastUpdated": false,
      "mergeDataValues": false,
      "skipCache": false
    },
    "importSummaries": [
      {
        "responseType": "ImportSummary",
        "status": "ERROR",
        "description":
            "TrackedEntityInstance x2kJgpb0XQC already has an active or completed enrollment in program IpHINAT79UW, and this program only allows enrolling one time",
        "importCount": {
          "imported": 0,
          "updated": 0,
          "ignored": 1,
          "deleted": 0
        },
        "conflicts": [],
        "events": {
          "responseType": "ImportSummaries",
          "status": "SUCCESS",
          "imported": 0,
          "updated": 0,
          "deleted": 0,
          "ignored": 0,
          "importSummaries": [],
          "total": 0
        }
      },
      {
        "responseType": "ImportSummary",
        "status": "ERROR",
        "description":
            "TrackedEntityInstance PQfMcpmXeFE already has an active or completed enrollment in program IpHINAT79UW, and this program only allows enrolling one time",
        "importCount": {
          "imported": 0,
          "updated": 0,
          "ignored": 1,
          "deleted": 0
        },
        "conflicts": [],
        "events": {
          "responseType": "ImportSummaries",
          "status": "SUCCESS",
          "imported": 0,
          "updated": 0,
          "deleted": 0,
          "ignored": 0,
          "importSummaries": [],
          "total": 0
        }
      }
    ],
    "total": 2
  }
};

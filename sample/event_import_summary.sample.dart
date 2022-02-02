final Map<Object, dynamic> sampleEventImportSummary = {
  "httpStatus": "Conflict",
  "httpStatusCode": 409,
  "status": "ERROR",
  "message": "An error occurred, please check import summary.",
  "response": {
    "responseType": "ImportSummaries",
    "status": "ERROR",
    "imported": 1,
    "updated": 0,
    "deleted": 0,
    "ignored": 1,
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
            "Program stage is not repeatable and an event already exists",
        "importCount": {
          "imported": 0,
          "updated": 0,
          "ignored": 1,
          "deleted": 0
        },
        "conflicts": [],
        "reference": "NUE7a9V9dxi"
      },
      {
        "responseType": "ImportSummary",
        "status": "SUCCESS",
        "importCount": {
          "imported": 1,
          "updated": 0,
          "ignored": 0,
          "deleted": 0
        },
        "conflicts": [],
        "reference": "Tr95hr7sher",
        "href": "https://play.dhis2.org/2.35.11/api/events/Tr95hr7sher"
      }
    ],
    "total": 2
  }
};

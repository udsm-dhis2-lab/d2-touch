final Map<Object, dynamic> sampleTrackedEntityInstanceImportSummary = {
  "httpStatus": "Conflict",
  "httpStatusCode": 409,
  "status": "ERROR",
  "message": "An error occurred, please check import summary.",
  "response": {
    "responseType": "ImportSummaries",
    "status": "ERROR",
    "imported": 0,
    "updated": 1,
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
      "skipLastUpdated": true,
      "mergeDataValues": false,
      "skipCache": false
    },
    "importSummaries": [
      {
        "responseType": "ImportSummary",
        "status": "SUCCESS",
        "importCount": {
          "imported": 0,
          "updated": 1,
          "ignored": 0,
          "deleted": 0
        },
        "conflicts": [],
        "reference": "VYhjy99cyVv",
        "href":
            "https://play.dhis2.org/2.35.11/api/trackedEntityInstances/x2kJgpb0XQC",
        "enrollments": {
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
        "importCount": {
          "imported": 0,
          "updated": 0,
          "ignored": 1,
          "deleted": 0
        },
        "conflicts": [
          {
            "object": "Attribute.attribute",
            "value": "Invalid attribute VEFza8wbwA"
          }
        ],
        "reference": "PQfMcpmXeFE",
        "enrollments": {
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

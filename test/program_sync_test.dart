import 'package:dhis2_flutter_sdk/d2_touch.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program.query.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'program_sync_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;

  await D2Touch.initialize(
      databaseFactory: databaseFactoryFfi, databaseName: 'flutter_test');

  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  UserQuery userQuery = UserQuery(database: db);

  Map<String, dynamic> userData = {
    "lastUpdated": "2018-12-03T13:24:26.356",
    "id": "xE7jOejl9FI",
    "created": "2013-04-18T17:15:08.407",
    "name": "John Traore",
    "birthday": "1971-04-08T00:00:00.000",
    "education": "Master of super using",
    "gender": "gender_male",
    "displayName": "John Traore",
    "jobTitle": "Super user",
    "externalAccess": false,
    "skype": "john.traore",
    "twitter": "john.traore",
    "surname": "Traore",
    "employer": "DHIS",
    "facebookMessenger": "john.traore",
    "introduction": "I am the super user of DHIS 2",
    "email": "dummy@dhis2.org",
    "whatsApp": "+123123123123",
    "languages": "English",
    "telegram": "john.traore",
    "sharing": {"external": false, "users": {}, "userGroups": {}},
    "lastCheckedInterpretations": "2016-10-13T11:51:34.317",
    "firstName": "John",
    "nationality": "Sierra Leone",
    "interests": "Football, swimming, singing, dancing",
    "favorite": false,
    "access": {
      "read": true,
      "update": true,
      "externalize": false,
      "delete": true,
      "write": true,
      "manage": true
    },
    "userCredentials": {
      "code": "admin",
      "lastUpdated": "2022-01-10T12:20:35.060",
      "id": "ZyjSDLHGPv4",
      "created": "2013-04-18T17:15:08.401",
      "name": "John Traore",
      "lastLogin": "2022-01-10T12:20:35.059",
      "displayName": "John Traore",
      "externalAuth": false,
      "externalAccess": false,
      "disabled": false,
      "twoFA": false,
      "passwordLastUpdated": "2014-12-18T20:56:05.264",
      "invitation": false,
      "sharing": {"external": false, "users": {}, "userGroups": {}},
      "selfRegistered": false,
      "favorite": false,
      "username": "admin",
      "userInfo": {"id": "xE7jOejl9FI"},
      "access": {
        "read": true,
        "update": true,
        "externalize": false,
        "delete": true,
        "write": true,
        "manage": true
      },
      "lastUpdatedBy": {
        "displayName": "John Traore",
        "name": "John Traore",
        "id": "xE7jOejl9FI",
        "username": "admin"
      },
      "createdBy": {
        "displayName": "John Traore",
        "name": "John Traore",
        "id": "xE7jOejl9FI",
        "username": "admin"
      },
      "user": {
        "displayName": "John Traore",
        "name": "John Traore",
        "id": "xE7jOejl9FI",
        "username": "admin"
      },
      "favorites": [],
      "cogsDimensionConstraints": [],
      "catDimensionConstraints": [],
      "translations": [],
      "userGroupAccesses": [],
      "attributeValues": [],
      "userRoles": [
        {"id": "UYXOT4A7JMI"}
      ],
      "userAccesses": []
    },
    "settings": {},
    "favorites": [],
    "teiSearchOrganisationUnits": [],
    "translations": [],
    "organisationUnits": [
      {"id": "ImspTQPwCqd"}
    ],
    "dataViewOrganisationUnits": [],
    "userGroupAccesses": [],
    "attributeValues": [],
    "userGroups": [
      {"id": "Kk12LkEWtXp"},
      {"id": "M1Qre0247G3"}
    ],
    "userAccesses": [],
    "authorities": ["F_PROGRAM_INDICATOR_PUBLIC_ADD"],
    "programs": ["eBAyeGv0exc", "fDd25txQckK"],
    "dataSets": ["Nyh6laLdBEJ", "j38YW1Am7he", "aLpVgfXiz0f"]
  };

  final dhisPrograms = {
    "pager": {"page": 1, "pageCount": 1, "total": 14, "pageSize": 50},
    "programs": [
      {
        "lastUpdated": "2021-09-16T11:24:39.510",
        "id": "lxAQ7Zs9VYR",
        "created": "2016-04-12T15:30:43.783",
        "name": "Antenatal care visit",
        "shortName": "Antenatal care",
        "displayName": "Antenatal care visit",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Enrollment Date",
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident Date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [
          {"id": "omrL0gtPpDL"},
          {"id": "Z92dJO9gIje"}
        ],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T09:49:07.935",
        "id": "IpHINAT79UW",
        "created": "2013-03-04T11:41:07.494",
        "name": "Child Programme",
        "shortName": "Child Programme",
        "displayName": "Child Programme",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "featureType": "POINT",
        "displayFrontPageList": true,
        "enrollmentDateLabel": "Date of enrollment",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": true,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Date of birth",
        "displayIncidentDate": true,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": true,
        "trackedEntityType": {"id": "nEenWmSyUEp"},
        "programRuleVariables": [
          {"id": "g2GooOydipB"},
          {"id": "aKpfPKSRQnv"}
        ],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T09:58:04.936",
        "id": "kla3mAPgvCH",
        "created": "2015-10-20T12:05:27.374",
        "name": "Contraceptives Voucher Program",
        "shortName": "Contraceptives Voucher Program",
        "displayName": "Contraceptives Voucher Program",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Enrollment Date",
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident Date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:01:21.082",
        "id": "q04UBOqq3rp",
        "created": "2014-06-22T13:28:24.004",
        "name": "Information Campaign",
        "shortName": "Information Campaign",
        "displayName": "Information Campaign",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Enrollment Date",
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident Date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:01:48.530",
        "id": "eBAyeGv0exc",
        "created": "2013-03-04T11:41:07.494",
        "name": "Inpatient morbidity and mortality",
        "shortName": "Inpatient morbidity and mortality",
        "displayName": "Inpatient morbidity and mortality",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Date of Discharge",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [
          {"id": "RycV5uDi66i"},
          {"id": "zINGRka3g9N"}
        ],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:02:43.519",
        "id": "qDkgAbB5Jlk",
        "created": "2016-05-27T12:34:03.503",
        "name": "Malaria case diagnosis, treatment and investigation",
        "shortName": "Case",
        "displayName": "Malaria case diagnosis, treatment and investigation",
        "description":
            "All cases in an elimination setting should be registered in this program. Includes relevant case identifiers/details including the ID, Name, Index, Age, Gender, Location,etc..",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "displayFrontPageList": true,
        "enrollmentDateLabel": "Enrollment date",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": true,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident Date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "Zy2SEgA61ys"},
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:03:04.659",
        "id": "VBqh0ynB2wv",
        "created": "2016-03-30T20:18:31.020",
        "name": "Malaria case registration",
        "shortName": "Malaria case registration",
        "displayName": "Malaria case registration",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Enrollment Date",
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident Date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:03:27.476",
        "id": "M3xtLkYBlKI",
        "created": "2017-06-29T11:39:54.922",
        "name": "Malaria focus investigation",
        "shortName": "Focus",
        "displayName": "Malaria focus investigation",
        "description":
            "It allows to register new focus areas in the system. Each focus area needs to be investigated and classified. Includes the relevant identifiers for the foci including the name and geographical details including the locality and its area. ",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "displayFrontPageList": true,
        "enrollmentDateLabel": "Date of Focus Registration",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Incident date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "We9I19a3vO1"},
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:03:49.741",
        "id": "bMcwwoVnbSR",
        "created": "2017-05-22T16:34:38.445",
        "name": "Malaria testing and surveillance",
        "shortName": "Malaria testing and surveillance",
        "displayName": "Malaria testing and surveillance",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "displayIncidentDate": true,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:02:10.869",
        "id": "uy2gU8kT1jF",
        "created": "2013-03-04T11:41:07.494",
        "name": "MNCH / PNC (Adult Woman)",
        "shortName": "MNCH / PNC (Adult Woman)",
        "displayName": "MNCH / PNC (Adult Woman)",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Date of enrollment",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "LMP Date",
        "displayIncidentDate": true,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "nEenWmSyUEp"},
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:04:11.465",
        "id": "fDd25txQckK",
        "created": "2014-04-25T15:14:18.868",
        "name": "Provider Follow-up and Support Tool",
        "shortName": "Provider Follow-up and Support Tool",
        "displayName": "Provider Follow-up and Support Tool",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Date of reporting",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Date of training",
        "displayIncidentDate": true,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "nEenWmSyUEp"},
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:04:31.460",
        "id": "ur1Edk5Oe2n",
        "created": "2013-03-04T11:41:07.494",
        "name": "TB program",
        "shortName": "TB program",
        "displayName": "TB program",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Start of treatment date",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "incidentDateLabel": "Start of treatment date",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "nEenWmSyUEp"},
        "programRuleVariables": [],
        "organisationUnits": []
      },
      {
        "lastUpdated": "2021-09-16T10:04:54.018",
        "id": "WSGAb5XwJ3Y",
        "created": "2014-06-06T20:44:21.375",
        "name": "WHO RMNCH Tracker",
        "shortName": "WHO RMNCH Tracker",
        "displayName": "WHO RMNCH Tracker",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": false,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "enrollmentDateLabel": "Date of first visit",
        "programType": "WITH_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": true,
        "incidentDateLabel": "Date of incident",
        "displayIncidentDate": false,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "trackedEntityType": {"id": "nEenWmSyUEp"},
        "programRuleVariables": [
          {"id": "mYMJHVqdBKt"},
          {"id": "M3dL6ZAIZ3I"},
          {"id": "o0BgK1dLhF8"},
          {"id": "T3iVyvrCpZ0"},
        ]
      },
      {
        "lastUpdated": "2021-09-16T10:05:19.023",
        "id": "MoUd5BTQ3lY",
        "created": "2018-08-28T12:22:43.057",
        "name": "XX MAL RDT - Case Registration",
        "shortName": "XX MAL RDT - Case Registration",
        "displayName": "XX MAL RDT - Case Registration",
        "completeEventsExpiryDays": 0,
        "ignoreOverdueEvents": false,
        "withoutRegistration": true,
        "featureType": "NONE",
        "displayFrontPageList": false,
        "programType": "WITHOUT_REGISTRATION",
        "onlyEnrollOnce": false,
        "selectIncidentDatesInFuture": false,
        "displayIncidentDate": true,
        "selectEnrollmentDatesInFuture": false,
        "useFirstStageDuringRegistration": false,
        "programRuleVariables": [
          {"id": "Q2zYkzn2fu7"},
          {"id": "i47jDXmfVOC"},
          {"id": "Bn9GkaU8ayh"}
        ],
        "organisationUnits": [
          {"id": "U7yKrx2QVet"},
          {"id": "V6QWyB0KqvP"},
          {"id": "TAN6Q7vjvuk"},
          {"id": "nornKUJmQqn"},
          {"id": "DXegteybeb5"},
          {"id": "ZvX8lXd1tYs"},
        ]
      }
    ]
  };

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programs.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariables&paging=true',
    (server) => server.reply(200, dhisPrograms),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromJson(userData);
  await userQuery.setData(user).save();
  final programQuery = ProgramQuery(database: db);

  List<Program>? programDownload =
      await programQuery.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<Program> programs = await programQuery.get();

  test('should store all incoming program metadata', () {
    expect(programs.length, 14);
  });
}

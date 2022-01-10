import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:dhis2_flutter_sdk/modules/sync/models/error_message.model.dart';
import 'package:dhis2_flutter_sdk/modules/sync/models/query-request.model.dart';
import 'package:dhis2_flutter_sdk/modules/sync/models/query-resource.model.dart';
import 'package:dhis2_flutter_sdk/modules/sync/models/request_progress.model.dart';
import 'package:sqflite/sqflite.dart';

class Sync {
  List<RequestProgress>? requestProgresses;
  late bool metadataSyncInProgress;
  bool? isDbOperationInitiated;
  ErrorMessage? finalError;

  Sync() {
    this.metadataSyncInProgress = false;
  }

  download({Database? database}) async {
    if (!this.metadataSyncInProgress) {
      this.metadataSyncInProgress = true;

      try {
        final User? currentUser = await UserQuery(database: database).getOne();

        // final queryResources =
        //     QueryResource.getQueryResources(currentUser: currentUser);
        // print(OrganisationUnitQuery(database: database).getQuery());

        final OrganisationUnitQuery orgUnitQuery =
            OrganisationUnitQuery(database: database);

        print(orgUnitQuery.getQuery());

        final QueryResource orgUniResource =
            QueryResource(name: 'organisationUnits', query: null);

        print(orgUniResource);

        List<QueryRequest> queryRequests = QueryRequest.getQueryRequests([
          QueryResource(
              name: 'organisationUnits',
              query: OrganisationUnitQuery(database: database).getQuery())
        ]);
      } catch (e) {}
    }
  }
}

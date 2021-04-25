import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';

class OrganisationUnitModule {
  static createTables() async {
    return await OrganisationUnitQuery().createTable();
  }

  OrganisationUnitQuery organisationUnit = OrganisationUnitQuery();
}

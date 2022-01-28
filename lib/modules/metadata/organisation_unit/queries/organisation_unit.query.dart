import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user_organisation_unit.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class OrganisationUnitQuery extends BaseQuery<OrganisationUnit> {
  OrganisationUnitQuery({Database? database}) : super(database: database);

  Future<List<OrganisationUnit>>? getUserOrgUnits() async {
    final List<UserOrganisationUnit> userOrgUnits =
        await UserOrganisationUnitQuery(database: database).get();

    final userOrgUnitIds =
        userOrgUnits.map((orgUnit) => orgUnit.orgUnit).toList();

    return this.byIds(userOrgUnitIds).get();
  }
}

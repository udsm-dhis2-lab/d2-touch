import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user_organisation_unit.query.dart';

class UserModule {
  static createTables() async {
    await UserQuery().createTable();
    await UserOrganisationUnitQuery().createTable();
  }

  static logOut() async {}

  UserQuery user = UserQuery();

  UserOrganisationUnitQuery userOrganisationUnit = UserOrganisationUnitQuery();
}

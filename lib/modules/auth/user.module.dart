import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/auth/queries/user_authority.query.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/auth/queries/user_role.query.dart';

class UserModule {
  static createTables() async {
    await UserQuery().createTable();
    await UserOrganisationUnitQuery().createTable();
    await UserAuthorityQuery().createTable();
    await UserRoleQuery().createTable();
  }

  static logOut() async {}

  UserQuery user = UserQuery();

  UserOrganisationUnitQuery userOrganisationUnit = UserOrganisationUnitQuery();

  UserAuthorityQuery userAuthority = UserAuthorityQuery();

  UserRoleQuery userRole = UserRoleQuery();
}

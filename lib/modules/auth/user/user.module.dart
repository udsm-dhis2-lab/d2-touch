import 'package:d2_touch/modules/auth/user/entities/user_authority.entity.dart';
import 'package:d2_touch/modules/auth/user/queries/user.query.dart';
import 'package:d2_touch/modules/auth/user/queries/user_authority.query.dart';
import 'package:d2_touch/modules/auth/user/queries/user_organisation_unit.query.dart';

class UserModule {
  static createTables() async {
    await UserQuery().createTable();
    await UserOrganisationUnitQuery().createTable();
    await UserAuthorityQuery().createTable();
  }

  static logOut() async {}

  UserQuery user = UserQuery();

  UserOrganisationUnitQuery userOrganisationUnit = UserOrganisationUnitQuery();

  UserAuthorityQuery userAuthority = UserAuthorityQuery();
}

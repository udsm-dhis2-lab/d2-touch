import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/auth/queries/user_authority.query.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/auth/queries/user_role.query.dart';
import 'package:sqflite/sqflite.dart';

class UserModule {
  Database? database;
  UserModule({this.database, String? locale}) {}
  static createTables({required Database database}) async {
    await UserQuery(database: database).createTable();
    await UserOrganisationUnitQuery(database: database).createTable();
    await UserAuthorityQuery(database: database).createTable();
    await UserRoleQuery(database: database).createTable();
  }

  dispose() {
    database = null;
  }

  UserQuery get user => UserQuery(database: database);

  UserOrganisationUnitQuery get userOrganisationUnit =>
      UserOrganisationUnitQuery(database: database);

  UserAuthorityQuery get userAuthority =>
      UserAuthorityQuery(database: database);

  UserRoleQuery get userRole => UserRoleQuery(database: database);
}

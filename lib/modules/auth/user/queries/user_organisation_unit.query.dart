import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class UserOrganisationUnitQuery extends BaseQuery<UserOrganisationUnit> {
  UserOrganisationUnitQuery({Database? database}) : super(database: database);
}

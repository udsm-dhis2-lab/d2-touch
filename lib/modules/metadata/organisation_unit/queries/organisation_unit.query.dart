import 'dart:convert';

import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/queries/user.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class OrganisationUnitQuery extends BaseQuery<OrganisationUnit> {
  OrganisationUnitQuery({Database? database}) : super(database: database);

  Future<List<OrganisationUnit>>? getUserOrgUnits() async {
    final User? user = await UserQuery(database: database).getOne();

    print((user?.organisationUnits));
    // final userOrgUnitIds =
    //     (json.decode(user?.organisationUnits as String) as List).map((orgUnit) {
    //   print(orgUnit);
    //   return orgUnit;
    // });

    return [];
  }
}

import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class OrganisationUnitQuery extends BaseQuery<OrganisationUnit> {
  OrganisationUnitQuery({Database database}) : super(database: database);
}

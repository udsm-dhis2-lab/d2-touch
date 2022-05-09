import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:sqflite/sqflite.dart';

class QueryResource {
  String name;
  String dhisUrl;

  QueryResource({required this.name, required this.dhisUrl});

  static List<QueryResource> getQueryResources(
      {User? currentUser, dynamic enableResources, Database? database}) {
    return QueryResource.getAllResources(database: database);
  }

  static List<QueryResource> getAllResources({Database? database}) {
    return [
      QueryResource(name: 'organisationUnits', dhisUrl: ''),
    ];
  }
}

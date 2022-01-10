import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/query_model.util.dart';

class QueryResource {
  late String name;
  QueryModel? query;

  QueryResource({required this.name, this.query});

  static List<QueryResource> getQueryResources({
    User? currentUser,
    dynamic enableResources,
  }) {
    print(currentUser?.organisationUnits);
    return [];
  }
}

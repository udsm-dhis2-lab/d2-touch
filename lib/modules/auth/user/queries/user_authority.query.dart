import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_authority.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class UserAuthorityQuery extends BaseQuery<UserAuthority> {
  UserAuthorityQuery({Database? database}) : super(database: database);
}

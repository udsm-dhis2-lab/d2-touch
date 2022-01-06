import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class UserQuery extends BaseQuery<User> {
  UserQuery({Database? database}) : super(database: database);
}

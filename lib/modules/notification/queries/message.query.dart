import 'package:dhis2_flutter_sdk/modules/notification/entities/message.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class MessageQuery extends BaseQuery<Message> {
  MessageQuery({Database? database}) : super(database: database);
}

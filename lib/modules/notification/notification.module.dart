import 'package:d2_touch/modules/notification/queries/message_conversation.query.dart';

import 'queries/message.query.dart';

class NotificationModule {
  static createTables() async {
    await MessageConversationQuery().createTable();
    await MessageQuery().createTable();
  }

  MessageConversationQuery get messageConversation =>
      MessageConversationQuery();

  MessageQuery get message => MessageQuery();
}

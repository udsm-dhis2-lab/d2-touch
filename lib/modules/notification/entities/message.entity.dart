import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'message_conversation.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'message', apiResourceName: 'messages')
class Message extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String sender;

  @Column(type: ColumnType.TEXT)
  String text;

  @ManyToOne(joinColumnName: 'messageConversation', table: MessageConversation)
  dynamic messageConversation;

  Message(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required String shortName,
      String? code,
      String? displayName,
      required this.sender,
      required this.text,
      required this.messageConversation,
      required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        shortName: json['shortName'],
        code: json['code'],
        displayName: json['displayName'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        text: json['text'],
        sender: json['sender'],
        messageConversation: json['messageConversation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    data['dirty'] = this.dirty;
    data['text'] = this.text;
    data['sender'] = this.sender;
    data['messageConversation'] = this.messageConversation;

    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'message.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'messageconversation', apiResourceName: 'messageConversations')
class MessageConversation extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String status;

  @Column(type: ColumnType.TEXT)
  String subject;

  @Column(type: ColumnType.TEXT)
  String messageType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? lastMessage;

  @Column(type: ColumnType.BOOLEAN)
  bool read;

  @OneToMany(table: Message)
  List<Message>? messages;

  MessageConversation(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      String? shortName,
      required this.status,
      required this.subject,
      required this.messageType,
      required this.read,
      String? displayName,
      this.messages,
      this.lastMessage,
      required bool dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory MessageConversation.fromJson(Map<String, dynamic> json) {
    return MessageConversation(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        shortName: json['shortName'],
        displayName: json['displayName'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        status: json['status'],
        messageType: json['messageType'],
        read: json['read'],
        subject: json['subject'],
        lastMessage: json['lastMessage'],
        messages: (json['messages'] ?? [])
            .map((message) => Message.fromJson({
                  ...message,
                  'dirty': false,
                  'messageConversation': json['id']
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['displayName'] = this.displayName;
    data['status'] = this.status;
    data['messageType'] = this.messageType;
    data['read'] = this.read;
    data['subject'] = this.subject;
    data['lastMessage'] = this.lastMessage;
    data['dirty'] = this.dirty;

    return data;
  }
}

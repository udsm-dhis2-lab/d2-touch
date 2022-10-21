import 'dart:convert';
import 'dart:core';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'message_conversation.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'message', apiResourceName: 'messages')
class Message extends IdentifiableEntity {
  @Column(nullable: true)
  String? sender;

  @Column()
  String text;

  @ManyToOne(joinColumnName: 'messageConversation', table: MessageConversation)
  dynamic messageConversation;

  Message(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      String? displayName,
      this.sender,
      required this.text,
      required this.messageConversation,
      required dirty})
      : super(
            id: id,
            name: name,
            displayName: displayName,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory Message.fromJson(Map<String, dynamic> json) {
    const JsonEncoder encoder = JsonEncoder();
    final dynamic sender = encoder.convert(json['sender']);

    return Message(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        displayName: json['displayName'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        text: json['text'],
        sender: sender.toString(),
        messageConversation: json['messageConversation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['dirty'] = this.dirty;
    data['text'] = this.text;
    data['sender'] = this.sender;
    data['messageConversation'] = this.messageConversation;

    return data;
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';


@AnnotationReflectable
@Entity(tableName: 'messageconversation', apiResourceName: 'messageConversations')
class MessageConversation extends BaseEntity {
  @Column(type: ColumnType.TEXT)
  String status;

  @Column(type: ColumnType.TEXT)
  String subject;

  @Column(type: ColumnType.TEXT)
  String messageType;

  @Column(type: ColumnType.TEXT)
  String lastMessage;

  @Column(type: ColumnType.BOOLEAN)
  bool read;

  @OneToMany(table: Message)
  List<Message>? messages;

  MessageConversation(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required String shortName,
      String? code,
      String? displayName,
      required this.sender,
      required this.text,
      this.messages,
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

  factory MessageConversation.fromJson(Map<String, dynamic> json) {
    return MessageConversation(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        shortName: json['shortName'],
        code: json['code'],
        displayName: json['displayName'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        dataElement: json['text'],
        attributeOptionCombo: json['sender']);
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
    
    return data;
  }
}

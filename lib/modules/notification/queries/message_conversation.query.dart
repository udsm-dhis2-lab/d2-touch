import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/notification/entities/message.entity.dart';
import 'package:dhis2_flutter_sdk/modules/notification/entities/message_conversation.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class MessageConversationQuery extends BaseQuery<MessageConversation> {
  MessageConversationQuery({Database? database}) : super(database: database);

  MessageConversationQuery withMessages() {
    final message = Repository<Message>();
    final Column? relationColumn = message.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'messages',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(Message) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(Message) as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }
}

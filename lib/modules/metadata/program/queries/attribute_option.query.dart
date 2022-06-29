import 'package:d2_touch/modules/metadata/program/entities/attribute_option.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class AttributeOptionQuery extends BaseQuery<AttributeOption> {
  AttributeOptionQuery({Database? database}) : super(database: database);
}

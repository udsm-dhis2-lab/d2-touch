import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/attribute_option.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class AttributeOptionQuery extends BaseQuery<AttributeOption> {
  AttributeOptionQuery({Database? database}) : super(database: database);
}

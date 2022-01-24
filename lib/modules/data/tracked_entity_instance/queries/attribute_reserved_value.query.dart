import 'package:dhis2_flutter_sdk/modules/data/tracked_entity_instance/entities/attribute_reserved_value.entity.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class AttributeReservedValueQuery extends BaseQuery<AttributeReservedValue> {
  AttributeReservedValueQuery({Database? database}) : super(database: database);
}

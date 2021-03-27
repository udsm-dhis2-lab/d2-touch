import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:flutter/foundation.dart';

class EntityOptions {
  final String name;
  final String engine;
  final String schema;
  final bool synchronize;
  final bool withoutRowid;
  EntityOptions(
      {this.name,
      this.engine,
      this.schema,
      this.synchronize,
      this.withoutRowid});
}

@AnnotationReflectable
class Entity {
  final String tableName;
  final EntityOptions options;
  const Entity({@required this.tableName, this.options});
}

import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:flutter/foundation.dart';

class ColumnType {}

@AnnotationReflectable
class Column {
  final String type;
  final String name;
  final int length;
  final int width;
  final bool nullable;
  final bool readonly;
  final bool unique;
  final bool primary;
  final bool select;
  final bool generated;
  const Column(
      {@required this.type,
      this.name,
      this.length = 255,
      this.width,
      this.nullable = false,
      this.readonly = false,
      this.unique = false,
      this.primary = false,
      this.select = true,
      this.generated = false});
}

@AnnotationReflectable
class PrimaryColumn extends Column {
  const PrimaryColumn({@required String type})
      : super(type: type, primary: true);
}

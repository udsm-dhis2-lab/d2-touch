import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
class OneToOne {
  const OneToOne();
}

@AnnotationReflectable
class ManyToOne {
  final String joinColumnName;
  final String parentTable;
  const ManyToOne({
    @required this.parentTable,
    this.joinColumnName,
  });
}

@AnnotationReflectable
class OneToMany {
  const OneToMany();
}

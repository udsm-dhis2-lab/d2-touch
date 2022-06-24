import 'package:d2_touch/core/annotations/reflectable.annotation.dart';

@AnnotationReflectable
class OneToOne {
  const OneToOne();
}

@AnnotationReflectable
class ManyToOne {
  final Type table;
  final String joinColumnName;
  final String? parentTable;
  const ManyToOne({
    this.parentTable,
    required this.table,
    required this.joinColumnName,
  });
}

@AnnotationReflectable
class OneToMany {
  final Type table;
  const OneToMany({
    required this.table,
  });
}

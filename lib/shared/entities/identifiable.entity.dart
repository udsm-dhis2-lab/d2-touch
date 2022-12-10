import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
class IdentifiableEntity extends BaseEntity {
  @Column()
  String? name;

  @Column(nullable: true)
  final String? displayName;

  @Column(nullable: true)
  final String? shortName;

  @Column(nullable: true)
  final String? code;

  IdentifiableEntity({
    String? id,
    required bool dirty,
    this.name,
    this.displayName,
    this.shortName,
    String? lastUpdated,
    String? created,
    this.code,
  }) : super(id: id, dirty: dirty, created: created, lastUpdated: lastUpdated);
}

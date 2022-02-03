import 'package:dhis2_flutter_sdk/core/annotations/index.dart';

@AnnotationReflectable
class BaseEntity {
  @PrimaryColumn()
  final String id;

  @Column()
  final String? name;

  @Column(nullable: true)
  final String? displayName;

  @Column(nullable: true)
  final String? shortName;

  @Column(nullable: true)
  final String? lastUpdated;

  @Column(nullable: true)
  final String? created;

  @Column(nullable: true)
  final String? code;

  @Column()
  bool dirty;

  BaseEntity(
      {required this.id,
      this.name,
      this.displayName,
      this.shortName,
      this.lastUpdated,
      this.created,
      this.code,
      required this.dirty});

  static fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/dhis_uid_generator.util.dart';

@AnnotationReflectable
class BaseEntity {
  @PrimaryColumn()
  late String? id;

  @Column()
  String? name;

  @Column(nullable: true)
  final String? displayName;

  @Column(nullable: true)
  final String? shortName;

  @Column(nullable: true)
  String? lastUpdated;

  @Column(nullable: true)
  String? created;

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
      required this.dirty}) {
    this.id = this.id ?? DhisUidGenerator.generate();
    this.created = this.created ?? DateTime.now().toIso8601String();
    this.lastUpdated = this.lastUpdated ?? this.created;
  }

  static fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

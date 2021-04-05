import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
class BaseEntity {
  @PrimaryColumn()
  final String id;

  @Column(name: 'name')
  final String name;

  @Column(name: 'displayname', nullable: true)
  final String displayName;

  @Column(name: 'shortname', nullable: true)
  final String shortName;

  @Column(name: 'lastupdated', nullable: true)
  final String lastUpdated;

  @Column(name: 'created', nullable: true)
  final String created;

  @Column(name: 'code', nullable: true)
  final String code;

  @Column(name: 'dirty')
  final bool dirty;

  BaseEntity(
      {@required this.id,
      @required this.name,
      this.displayName,
      this.shortName,
      this.lastUpdated,
      this.created,
      this.code,
      @required this.dirty});

  fromJson(Map<String, dynamic> json) {
    // TODO: implement findOne
    throw UnimplementedError();
  }
}

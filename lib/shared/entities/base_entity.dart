import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

class BaseEntity {
  @PrimaryKey()
  final String id;

  @ColumnInfo(name: 'name', nullable: false)
  final String name;

  @ColumnInfo(name: 'displayname', nullable: true)
  final String displayName;

  @ColumnInfo(name: 'shortname', nullable: true)
  final String shortName;

  @ColumnInfo(name: 'lastupdated', nullable: true)
  final String lastUpdated;

  @ColumnInfo(name: 'created', nullable: true)
  final String created;

  @ColumnInfo(name: 'code', nullable: true)
  final String code;

  BaseEntity(
      {@required this.id,
      @required this.name,
      this.displayName,
      this.shortName,
      this.lastUpdated,
      this.created,
      this.code});
}

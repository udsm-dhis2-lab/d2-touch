import 'package:dhis2_flutter_sdk/core/annotations/column.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/entity.annotation.dart';
import 'package:dhis2_flutter_sdk/core/annotations/reflectable.annotation.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/geometry.entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'organisationunit')
class OrganisationUnit extends BaseEntity {
  @Column(type: ColumnType.INTEGER)
  int level;

  @Column()
  String path;

  @Column(nullable: true)
  bool externalAccess;

  @Column()
  String openingDate;

  @Column(nullable: true)
  Geometry geometry;

  @Column(name: 'parent', nullable: true)
  OrganisationUnit parent;

  OrganisationUnit(
      {@required String id,
      String created,
      String lastUpdated,
      @required String name,
      @required String shortName,
      String code,
      String displayName,
      @required this.level,
      @required this.path,
      this.externalAccess,
      @required this.openingDate,
      this.parent,
      this.geometry,
      @required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory OrganisationUnit.fromJson(Map<String, dynamic> json) {
    return OrganisationUnit(
        id: json['id'],
        name: json['name'],
        level: json['level'],
        created: json['created'],
        shortName: json['shortname'],
        code: json['code'],
        path: json['path'],
        displayName: json['displayname'],
        externalAccess: json['externalaccess'],
        openingDate: json['openingdate'],
        dirty: json['dirty'],
        geometry: json['geometry'] != null
            ? Geometry.fromJson(json['geometry'])
            : null,
        parent: json['parent'].runtimeType == String
            ? {"id": json['parent']}
            : json['parent'] != null
                ? OrganisationUnit.fromJson(json['parent'])
                : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['level'] = this.level;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['path'] = this.path;
    data['displayName'] = this.displayName;
    data['externalAccess'] = this.externalAccess;
    data['openingDate'] = this.openingDate;
    data['dirty'] = this.dirty;
    if (this.parent != null) {
      data['parent'] = this.parent.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    return data;
  }
}

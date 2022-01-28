import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

import 'user.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'userOrganisationUnit', apiResourceName: 'userOrganisationUnits')
class UserOrganisationUnit extends BaseEntity {
  @Column()
  final String orgUnit;

  @Column()
  final String type;

  @ManyToOne(joinColumnName: 'user', table: User)
  dynamic user;

  UserOrganisationUnit(
      {required String id,
      required String name,
      required this.orgUnit,
      required this.user,
      required this.type,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory UserOrganisationUnit.fromJson(Map<String, dynamic> json) {
    return UserOrganisationUnit(
        id: json['id'],
        name: json['id'],
        orgUnit: json['orgUnit'],
        user: json['user'],
        type: json['type'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['orgUnit'] = this.orgUnit;
    data['type'] = this.type;
    data['user'] = this.user;
    data['dirty'] = this.dirty;
    return data;
  }
}

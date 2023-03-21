import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/auth/entities/user_group_user.entity.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'userGroup', apiResourceName: 'userGroups')
class UserGroup extends BaseEntity {
  @Column()
  String name;

  @OneToMany(table: UserGroupUser)
  List<UserGroupUser>? userGroupUsers;

  UserGroup(
      {String? id,
      required this.name,
      this.userGroupUsers,
      required bool dirty})
      : super(id: id, dirty: dirty);

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      id: json['id'],
      name: json['name'],
      userGroupUsers: json['userGroupUsers'],
      dirty: json['dirty'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['userGroupUsers'] = this.userGroupUsers;
    return data;
  }
}

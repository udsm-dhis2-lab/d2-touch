import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'user', apiResourceName: 'users')
class User extends BaseEntity {
  @Column()
  final String username;

  @Column()
  final String password;

  @Column()
  final String firstName;

  @Column()
  final String surname;

  @Column()
  final String baseUrl;

  @Column(nullable: true)
  final String? teiSearchOrganisationUnits;

  @OneToMany(table: UserOrganisationUnit)
  List<UserOrganisationUnit>? organisationUnits;

  @Column(nullable: true)
  final dynamic dataViewOrganisationUnits;

  @Column(nullable: true)
  final String? authorities;

  @Column(nullable: true)
  final String? programs;

  @Column(nullable: true)
  final String? dataSets;

  @Column()
  final bool isLoggedIn;

  User(
      {required String id,
      required this.username,
      required this.password,
      required this.firstName,
      required this.surname,
      required String name,
      required this.baseUrl,
      String? shortName,
      String? displayName,
      String? code,
      this.teiSearchOrganisationUnits,
      this.organisationUnits,
      this.dataViewOrganisationUnits,
      this.authorities,
      this.programs,
      this.dataSets,
      required this.isLoggedIn,
      required dirty})
      : super(id: id, name: name, dirty: dirty);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        firstName: json['firstName'],
        surname: json['surname'],
        name: json['name'],
        baseUrl: json['baseUrl'],
        teiSearchOrganisationUnits:
            json['teiSearchOrganisationUnits'].toString(),
        organisationUnits: json['organisationUnits'],
        dataViewOrganisationUnits: json['dataViewOrganisationUnits'],
        authorities: json['authorities'].toString(),
        programs: json['programs'].toString(),
        dataSets: json['datasets'].toString(),
        isLoggedIn: json['isLoggedIn'],
        dirty: false);
  }

  factory User.fromApi(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        firstName: json['firstName'],
        surname: json['surname'],
        name: json['name'],
        baseUrl: json['baseUrl'],
        teiSearchOrganisationUnits:
            json['teiSearchOrganisationUnits'].toString(),
        organisationUnits: json['organisationUnits']
            .map<UserOrganisationUnit>((orgUnit) => UserOrganisationUnit(
                id: '${json['id']}_${orgUnit['id']}',
                name: '${json['id']}_${orgUnit['id']}',
                orgUnit: orgUnit['id'],
                user: json['id'],
                type: 'DATA_VIEW',
                dirty: false))
            .toList(),
        dataViewOrganisationUnits: json['dataViewOrganisationUnits'],
        authorities: json['authorities'].toString(),
        programs: json['programs'].toString(),
        dataSets: json['datasets'].toString(),
        isLoggedIn: json['isLoggedIn'],
        dirty: false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['teiSearchOrganisationUnits'] = this.teiSearchOrganisationUnits;
    data['organisationUnits'] = this.organisationUnits;
    data['dataViewOrganisationUnits'] = this.dataViewOrganisationUnits;
    data['authorities'] = this.authorities;
    data['programs'] = this.programs;
    data['isLoggedIn'] = this.isLoggedIn;
    data['baseUrl'] = this.baseUrl;

    return data;
  }
}

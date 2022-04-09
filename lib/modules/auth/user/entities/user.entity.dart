import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/modules/auth/user/entities/user_organisation_unit.entity.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'user', apiResourceName: 'users')
class User extends BaseEntity {
  @Column(nullable: true)
  final String? username;

  @Column(nullable: true)
  final String? password;

  @Column()
  final String firstName;

  @Column(nullable: true)
  final String? surname;

  @Column(nullable: true)
  final String? token;

  @Column(nullable: true)
  final String? tokenType;

  @Column(nullable: true)
  final String? refreshToken;

  @Column(nullable: true)
  final int? tokenExpiry;

  @Column(nullable: true)
  final String? authType;

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
  bool isLoggedIn;

  User(
      {required String id,
      this.username,
      this.password,
      required this.firstName,
      required this.surname,
      required String name,
      required this.baseUrl,
      String? shortName,
      String? displayName,
      String? code,
      String? created,
      String? lastUpdated,
      this.teiSearchOrganisationUnits,
      this.organisationUnits,
      this.dataViewOrganisationUnits,
      this.authorities,
      this.programs,
      this.dataSets,
      this.token,
      this.tokenType,
      this.refreshToken,
      this.tokenExpiry,
      this.authType,
      required this.isLoggedIn,
      required bool dirty})
      : super(
            id: id,
            name: name,
            dirty: dirty,
            created: created,
            lastUpdated: lastUpdated);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        firstName: json['firstName'],
        surname: json['surname'],
        token: json['token'],
        tokenType: json['tokenType'],
        refreshToken: json['refreshToken'],
        tokenExpiry: json['tokenExpiry'],
        authType: json['authType'],
        name: json['name'],
        baseUrl: json['baseUrl'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        teiSearchOrganisationUnits:
            json['teiSearchOrganisationUnits'].toString(),
        organisationUnits: json['organisationUnits'],
        dataViewOrganisationUnits: json['dataViewOrganisationUnits'],
        authorities: json['authorities'].toString(),
        programs: json['programs'].toString(),
        dataSets: json['datasets'].toString(),
        isLoggedIn: json['isLoggedIn'],
        dirty: json['dirty']);
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
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        token: json['token'],
        tokenType: json['tokenType'],
        refreshToken: json['refreshToken'],
        tokenExpiry: json['tokenExpiry'],
        authType: json['authType'],
        teiSearchOrganisationUnits:
            json['teiSearchOrganisationUnits'].toString(),
        organisationUnits: json['organisationUnits']
            .map<UserOrganisationUnit>((orgUnit) => UserOrganisationUnit(
                id: '${json['id']}_${orgUnit['id']}',
                name: '${json['id']}_${orgUnit['id']}',
                orgUnit: orgUnit['id'],
                user: json['id'],
                type: 'DATA_VIEW',
                dirty: json['dirty'] ?? false))
            .toList(),
        dataViewOrganisationUnits: json['dataViewOrganisationUnits'],
        authorities: json['authorities'].toString(),
        programs: json['programs'].toString(),
        dataSets: json['datasets'].toString(),
        isLoggedIn: json['isLoggedIn'],
        dirty: json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['token'] = this.token;
    data['tokenType'] = this.tokenType;
    data['refreshToken'] = this.refreshToken;
    data['tokenExpiry'] = this.tokenExpiry;
    data['authType'] = this.authType;
    data['teiSearchOrganisationUnits'] = this.teiSearchOrganisationUnits;
    data['organisationUnits'] = this.organisationUnits;
    data['dataViewOrganisationUnits'] = this.dataViewOrganisationUnits;
    data['authorities'] = this.authorities;
    data['programs'] = this.programs;
    data['isLoggedIn'] = this.isLoggedIn;
    data['baseUrl'] = this.baseUrl;
    data['dirty'] = this.dirty;

    return data;
  }
}

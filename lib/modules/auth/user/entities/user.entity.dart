import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'user')
class User extends BaseEntity {
  @Column(name: 'username')
  final String username;

  @Column(name: 'password')
  final String password;

  @Column(name: 'firstname')
  final String firstName;

  @Column(name: 'surname')
  final String surname;

  @Column(name: 'teisearchorganisationunits', nullable: true)
  final String teiSearchOrganisationUnits;

  @Column(name: 'organisationunits', nullable: true)
  final String organisationUnits;

  @Column(name: 'datavieworganisationunits', nullable: true)
  final String dataViewOrganisationUnits;

  @Column(name: 'authorities', nullable: true)
  final String authorities;

  @Column(name: 'programs', nullable: true)
  final String programs;

  @Column(name: 'datasets', nullable: true)
  final String dataSets;

  @Column(name: 'isloggedin')
  final bool isLoggedIn;

  User(
      {@required String id,
      @required this.username,
      @required this.password,
      @required this.firstName,
      @required this.surname,
      String name,
      String shortName,
      String displayName,
      String code,
      this.teiSearchOrganisationUnits,
      this.organisationUnits,
      this.dataViewOrganisationUnits,
      this.authorities,
      this.programs,
      this.dataSets,
      this.isLoggedIn,
      @required dirty})
      : super(id: id, name: name, dirty: dirty);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        username: json['userCredentials']['username'],
        password: json['password'],
        firstName: json['firstName'],
        surname: json['surname'],
        name: json['name'],
        teiSearchOrganisationUnits:
            json['teiSearchorganisationUnits'].toString(),
        organisationUnits: json['organisationUnits'].toString(),
        dataViewOrganisationUnits: json['dataVieworganisationUnits'].toString(),
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
    data['dataVieworganisationUnits'] = this.dataViewOrganisationUnits;
    data['authorities'] = this.authorities;
    data['programs'] = this.programs;
    data['isLoggedIn'] = this.isLoggedIn;

    return data;
  }
}

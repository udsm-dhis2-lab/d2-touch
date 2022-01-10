import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
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

  @Column(nullable: true)
  final String? teiSearchOrganisationUnits;

  @Column(nullable: true)
  final String? organisationUnits;

  @Column(nullable: true)
  final String? dataViewOrganisationUnits;

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
        teiSearchOrganisationUnits:
            json['teiSearchOrganisationUnits'].toString(),
        organisationUnits: json['organisationUnits'].toString(),
        dataViewOrganisationUnits: json['dataViewOrganisationUnits'].toString(),
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

    return data;
  }
}

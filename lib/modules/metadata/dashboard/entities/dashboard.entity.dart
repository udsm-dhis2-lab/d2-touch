import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base_entity.dart';

@AnnotationReflectable
@Entity(tableName: 'dashboard', apiResourceName: 'dashboards')
class Dashboard extends BaseEntity {
  @Column(type: ColumnType.TEXT, name: 'formname', nullable: true)
  String? formName;

  @Column(type: ColumnType.INTEGER, name: 'itemcount', nullable: true)
  int? itemCount;

  Dashboard(
      {required String id,
      String? created,
      String? lastUpdated,
      String? displayName,
      required String name,
      this.formName,
      this.itemCount,
      required dirty})
      : super(
            id: id,
            name: name,
            created: created,
            displayName: displayName,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        displayName: json['displayName'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['dirty'] = this.dirty;

    return data;
  }
}

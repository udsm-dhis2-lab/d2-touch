import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/core/utilities/repository.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class DataValueSetQuery extends BaseQuery<DataValueSet> {
  String? orgUnit;
  String? dataSet;
  String? period;
  DataValueSetQuery({Database? database}) : super(database: database);

  DataValueSetQuery withDataValues() {
    final dataValue = Repository<DataValue>();

    final Column? relationColumn = dataValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'dataValues',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataValue) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataValue) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  DataValueSetQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this;
  }

  DataValueSetQuery byDataSet(String dataSet) {
    this.dataSet = dataSet;
    return this;
  }

  DataValueSetQuery byPeriod(String period) {
    this.period = period;
    return this;
  }

  @override
  // TODO: implement dhisUrl
  String get dhisUrl {
    return 'dataValueSets.json?dataSet=${this.dataSet}&period=${this.period}&orgUnit=${this.orgUnit}';
  }

  @override
  Future<List<DataValueSet>?> download(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading ${this.apiResourceName?.toLowerCase()} from the server....',
            status: '',
            percentage: 0),
        false);

    final response = await HttpClient.get(this.dhisUrl,
        database: this.database, dioTestClient: dioTestClient);

    final data = response.body;

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${this.apiResourceName?.toLowerCase()}(${this.dataSet}-${this.orgUnit}-${this.period}) downloaded successfully',
            status: '',
            percentage: 50),
        false);

    data['dirty'] = false;
    this.data = DataValueSet.fromJson(data);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Saving ${this.apiResourceName?.toLowerCase()}(${this.dataSet}-${this.orgUnit}-${this.period}) into phone database...',
            status: '',
            percentage: 51),
        false);

    final saveResponse = await this.save();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${this.apiResourceName?.toLowerCase()}(${this.dataSet}-${this.orgUnit}-${this.period}) successifully saved into the database',
            status: '',
            percentage: 100),
        true);

    return [this.data];
  }
}

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class DataValueSetQuery extends BaseQuery<DataValueSet> {
  String? orgUnit;
  String? dataSet;
  String? period;

  DataValueSetQuery({Database? database}) : super(database: database) {
    this.mergeMode = MergeMode.Merge;
  }

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
    return this.where(attribute: 'orgUnit', value: orgUnit);
  }

  DataValueSetQuery byDataSet(String dataSet) {
    this.dataSet = dataSet;
    return this.where(attribute: 'dataSet', value: dataSet);
  }

  DataValueSetQuery byPeriod(String period) {
    this.period = period;
    return this.where(attribute: 'period', value: period);
  }

  @override
  Future create() async {
    DataValueSet dataValueSet = DataValueSet(
        period: this.period as String,
        orgUnit: this.orgUnit as String,
        synced: false,
        dataSet: this.dataSet as String,
        dirty: true);

    this.data = dataValueSet;

    await this.save();

    return dataValueSet;
  }

  @override
  Future<String> dhisUrl() {
    return Future.value(
        'dataValueSets.json?dataSet=${this.dataSet}&period=${this
            .period}&orgUnit=${this.orgUnit}');
  }

  @override
  Future<List<DataValueSet>?> download(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
            'Downloading ${this.apiResourceName
                ?.toLowerCase()} from the server....',
            status: '',
            percentage: 0),
        false);

    final dhisUrl = await this.dhisUrl();
    final response = await HttpClient.get(dhisUrl,
        database: this.database, dioTestClient: dioTestClient);

    final data = response.body;

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
            '${this.apiResourceName?.toLowerCase()}(${this.dataSet}-${this
                .orgUnit}-${this.period}) downloaded successfully',
            status: '',
            percentage: 50),
        false);

    data['dirty'] = false;
    data['synced'] = true;
    this.data = DataValueSet.fromJson(data);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
            'Saving ${this.apiResourceName?.toLowerCase()}(${this
                .dataSet}-${this.orgUnit}-${this
                .period}) into phone database...',
            status: '',
            percentage: 51),
        false);

    await this.save();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
            '${this.apiResourceName?.toLowerCase()}(${this.dataSet}-${this
                .orgUnit}-${this
                .period}) successifully saved into the database',
            status: '',
            percentage: 100),
        true);

    return [this.data];
  }

  Future<List<DataValueSet>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<DataValueSet> dataValueSets = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .withDataValues()
        .get();

    List<String> dataValueSetIds = [];

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    dataValueSets.forEach((dataValueSet) {
      dataValueSetIds.add(dataValueSet.id as String);
      availableItemCount++;
      queue.add(
              () => this.uploadOne(dataValueSet, dioTestClient: dioTestClient));
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return await DataValueSetQuery().byIds(dataValueSetIds).get();
  }

  uploadOne(DataValueSet dataValueSet, {Dio? dioTestClient}) async {
    final uploadFormat = DataValueSet.toUpload(dataValueSet);

    final response = await HttpClient.post(
        this.apiResourceName as String, uploadFormat,
        database: this.database, dioTestClient: dioTestClient);


    final importSummary = response.body;
    final syncFailed = importSummary['status'] == 'ERROR';
    dataValueSet.synced = !syncFailed;
    dataValueSet.dirty = syncFailed;
    dataValueSet.syncFailed = syncFailed;
    dataValueSet.lastSyncDate = DateTime.now().toIso8601String().split('.')[0];
    dataValueSet.lastSyncSummary = importSummary.toString();

    return DataValueSetQuery().setData(dataValueSet).save();
  }
}

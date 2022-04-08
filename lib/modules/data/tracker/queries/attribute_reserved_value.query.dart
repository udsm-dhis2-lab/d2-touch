import 'package:dhis2_flutter_sdk/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';
import 'package:dhis2_flutter_sdk/shared/models/request_progress.model.dart';
import 'package:dhis2_flutter_sdk/shared/queries/base.query.dart';
import 'package:dhis2_flutter_sdk/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class AttributeReservedValueQuery extends BaseQuery<AttributeReservedValue> {
  AttributeReservedValueQuery({Database? database}) : super(database: database);

  @override
  String get dhisUrl {
    return 'trackedEntityAttributes/attributeID/generateAndReserve?numberToReserve=3';
  }

  @override
  Future<List<AttributeReservedValue>?> download(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Retrieving reserved attributes from phone database....',
            status: '',
            percentage: 0),
        false);
    List<ProgramTrackedEntityAttribute> reservedAttributes =
        await ProgramTrackedEntityAttributeQuery()
            .where(attribute: 'generated', value: true)
            .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${reservedAttributes.length} reserved attributes retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading and saving reserved values for ${reservedAttributes.length} reserved attributes...',
            status: '',
            percentage: 51),
        false);

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    reservedAttributes.forEach((reservedAttribute) {
      availableItemCount++;
      queue.add(() => downloadReservedValueByAttribute(reservedAttribute,
          dioTestClient: dioTestClient));
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Reserved values successifully saved into the database',
            status: '',
            percentage: 100),
        true);
    return await AttributeReservedValueQuery().get();
  }

  downloadReservedValueByAttribute(
      ProgramTrackedEntityAttribute reservedAttribute,
      {Dio? dioTestClient}) async {
    final int reservedCount = await AttributeReservedValueQuery()
        .where(attribute: 'attribute', value: reservedAttribute.attribute)
        .count();

    final numberToReserve = 100 - reservedCount;

    if (numberToReserve <= 0) {
      return null;
    }

    final response = await HttpClient.get(
        'trackedEntityAttributes/${reservedAttribute.attribute}/generateAndReserve?numberToReserve=$numberToReserve',
        database: this.database,
        dioTestClient: dioTestClient);

    List<AttributeReservedValue> reservedValues = [];

    (response.body ?? []).forEach((reservedResult) {
      reservedValues.add(
          AttributeReservedValue.fromJson({...reservedResult, 'dirty': false}));
    });

    return AttributeReservedValueQuery().setData(reservedValues).save();
  }
}

import 'package:d2_touch/shared/models/import_conflict.model.dart';
import 'package:d2_touch/shared/models/import_status.model.dart';
import 'package:d2_touch/shared/models/import_action.model.dart';
import 'package:d2_touch/shared/models/import_summary.model.dart';

class EventImportSummary extends ImportSummary {
  EventImportSummary({
    required ImportStatus status,
    required String reference,
    required ImportAction importAction,
    List<ImportConflict>? conflicts,
    required Map<String, dynamic> responseSummary,
  }) : super(
            status: status,
            reference: reference,
            importAction: importAction,
            conflicts: conflicts,
            responseSummary: responseSummary);

  factory EventImportSummary.fromJson(Map<String, dynamic> jsonData) {
    return EventImportSummary(
      responseSummary: jsonData,
      status: ImportStatusUtil.getStatus(jsonData['status']),
      reference: jsonData['reference'],
      importAction: ImportActionUtil.getAction(jsonData['importCount']),
      conflicts: List<dynamic>.from(jsonData['conflicts'])
          .map((conflict) => ImportConflict(
              object: conflict['object'], value: conflict['value']))
          .toList(),
    );
  }
}

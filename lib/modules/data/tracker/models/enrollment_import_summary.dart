import 'package:d2_touch/modules/data/tracker/models/event_import_summary.dart';
import 'package:d2_touch/shared/models/import_conflict.model.dart';
import 'package:d2_touch/shared/models/import_status.model.dart';
import 'package:d2_touch/shared/models/import_action.model.dart';
import 'package:d2_touch/shared/models/import_summary.model.dart';

class EnrollmentImportSummary extends ImportSummary {
  List<EventImportSummary>? eventImportSummaryList;
  EnrollmentImportSummary(
      {required ImportStatus status,
      required String reference,
      required ImportAction importAction,
      List<ImportConflict>? conflicts,
      required Map<String, dynamic> responseSummary,
      this.eventImportSummaryList})
      : super(
            status: status,
            reference: reference,
            conflicts: conflicts,
            importAction: importAction,
            responseSummary: responseSummary);

  factory EnrollmentImportSummary.fromJson(Map<String, dynamic> jsonData) {
    return EnrollmentImportSummary(
        responseSummary: jsonData,
        status: ImportStatusUtil.getStatus(jsonData['status']),
        reference: jsonData['reference'],
        importAction: ImportActionUtil.getAction(jsonData['importCount']),
        conflicts: List<dynamic>.from(jsonData['conflicts'])
            .map((conflict) => ImportConflict(
                object: conflict['object'], value: conflict['value']))
            .toList(),
        eventImportSummaryList: List<dynamic>.from(
                jsonData['events']!['importSummaries'] ?? [])
            .map((eventSummary) => EventImportSummary.fromJson(eventSummary))
            .toList());
  }
}

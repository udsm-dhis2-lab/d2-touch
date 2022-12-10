import 'package:d2_touch/modules/data/tracker/models/enrollment_import_summary.dart';
import 'package:d2_touch/shared/models/import_conflict.model.dart';
import 'package:d2_touch/shared/models/import_action.model.dart';
import 'package:d2_touch/shared/models/import_status.model.dart';
import 'package:d2_touch/shared/models/import_summary.model.dart';

class TrackedEntityInstanceImportSummary extends ImportSummary {
  List<EnrollmentImportSummary>? enrollmentImportSummaryList;
  TrackedEntityInstanceImportSummary(
      {required ImportStatus status,
      required String reference,
      required ImportAction importAction,
      required Map<String, dynamic> responseSummary,
      List<ImportConflict>? conflicts,
      this.enrollmentImportSummaryList})
      : super(
            status: status,
            reference: reference,
            importAction: importAction,
            responseSummary: responseSummary,
            conflicts: conflicts);

  factory TrackedEntityInstanceImportSummary.fromJson(
      Map<String, dynamic> jsonData) {
    return TrackedEntityInstanceImportSummary(
        responseSummary: jsonData,
        status: ImportStatusUtil.getStatus(jsonData['status']),
        reference: jsonData['reference'],
        importAction: ImportActionUtil.getAction(jsonData['importCount']),
        conflicts: List<dynamic>.from(jsonData['conflicts'])
            .map((conflict) => ImportConflict(
                object: conflict['object'], value: conflict['value']))
            .toList(),
        enrollmentImportSummaryList: List<dynamic>.from(
                jsonData['enrollments']!['importSummaries'] ?? [])
            .map((enrollmentSummary) =>
                EnrollmentImportSummary.fromJson(enrollmentSummary))
            .toList());
  }
}

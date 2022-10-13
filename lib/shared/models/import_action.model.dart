enum ImportAction { Updated, Ignored, Deleted, Created, Unkown }

class ImportActionUtil {
  static ImportAction getAction(dynamic importCount) {
    if (importCount['imported']! > 0) {
      return ImportAction.Created;
    }

    if (importCount['updated']! > 0) {
      return ImportAction.Updated;
    }

    if (importCount['deleted']! > 0) {
      return ImportAction.Deleted;
    }

    if (importCount['ignored']! > 0) {
      return ImportAction.Ignored;
    }

    return ImportAction.Unkown;
  }
}

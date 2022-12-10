enum ImportStatus { Success, Error, Warning, Unknown }

class ImportStatusUtil {
  static ImportStatus getStatus(String importStatus) {
    switch (importStatus) {
      case 'SUCCESS':
        return ImportStatus.Success;

      case 'ERROR':
        return ImportStatus.Error;

      case 'WARNING':
        return ImportStatus.Warning;
      default:
        return ImportStatus.Unknown;
    }
  }
}

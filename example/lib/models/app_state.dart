enum AppState {
  loading,
  unauthenticated,
  authenticated,
  error,
}

class SyncStatus {
  final String message;
  final double progress;
  final bool isCompleted;
  final bool hasError;
  final String? errorMessage;

  const SyncStatus({
    required this.message,
    required this.progress,
    required this.isCompleted,
    required this.hasError,
    this.errorMessage,
  });

  factory SyncStatus.initial() {
    return const SyncStatus(
      message: 'Ready to sync',
      progress: 0.0,
      isCompleted: false,
      hasError: false,
    );
  }

  factory SyncStatus.inProgress(String message, double progress) {
    return SyncStatus(
      message: message,
      progress: progress,
      isCompleted: false,
      hasError: false,
    );
  }

  factory SyncStatus.completed(String message) {
    return SyncStatus(
      message: message,
      progress: 1.0,
      isCompleted: true,
      hasError: false,
    );
  }

  factory SyncStatus.error(String message, String error) {
    return SyncStatus(
      message: message,
      progress: 0.0,
      isCompleted: false,
      hasError: true,
      errorMessage: error,
    );
  }
}

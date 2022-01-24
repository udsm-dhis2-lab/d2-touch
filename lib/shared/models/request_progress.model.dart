class RequestProgress {
  String resourceName;
  String message;
  String? serverMessage;
  String status;
  num percentage;

  RequestProgress(
      {required this.resourceName,
      required this.message,
      required this.status,
      required this.percentage,
      this.serverMessage});
}

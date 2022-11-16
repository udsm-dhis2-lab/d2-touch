class Geometry {
  String type;
  String latitude;
  String longitude;

  Geometry(
      {required this.type, required this.latitude, required this.longitude})
      : super();

  factory Geometry.fromJson(Map<String, dynamic> jsonData) {
    return Geometry(
        latitude: jsonData["coordinates"]?.length > 1
            ? jsonData["coordinates"][1]
            : "",
        longitude: jsonData["coordinates"]?.length > 1
            ? jsonData["coordinates"][0]
            : "",
        type: jsonData["type"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = [this.longitude, this.latitude];

    return data;
  }
}

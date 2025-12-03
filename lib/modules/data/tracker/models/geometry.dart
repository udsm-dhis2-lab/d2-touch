class Geometry {
  String type;
  double latitude;
  double longitude;
  Map<String, dynamic> geometryData;

  Geometry(
      {required this.type, required this.latitude, required this.longitude, required this.geometryData});

  factory Geometry.fromJson(Map<String, dynamic> jsonData) {
    return Geometry(
        latitude: jsonData["coordinates"]?.length > 1
            ? (jsonData["coordinates"][1] as num?)?.toDouble() ?? 0.0
            : 0.0,
        longitude: jsonData["coordinates"]?.length > 1
            ? (jsonData["coordinates"][0] as num?)?.toDouble() ?? 0.0
            : 0.0,
        type: jsonData["type"] ?? "Point",
        geometryData: jsonData);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = [this.longitude, this.latitude];

    return data;
  }
}

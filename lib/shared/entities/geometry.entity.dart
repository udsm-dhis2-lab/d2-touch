class Geometry {
  String type;
  List<dynamic> coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = List<dynamic>.from(json['coordinates']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }

  double get latitude {
    if (type == 'Point') {
      return coordinates.elementAt(1);
    }
    return null;
  }

  double get longitude {
    if (type == 'Point') {
      return coordinates.elementAt(0);
    }
    return null;
  }
}

class ObjectUtil {
  static Map<String, dynamic> removeNull(Map<String, dynamic> objectItem) {
    Map<String, dynamic> newObject = {};

    objectItem.keys.forEach((key) {
      final value = objectItem[key];

      if (value != null) {
        newObject[key] = value;
      }
    });

    return newObject;
  }
}

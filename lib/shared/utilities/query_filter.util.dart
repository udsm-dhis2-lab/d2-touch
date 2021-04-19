import 'package:flutter/foundation.dart';

class QueryFilter {
  String attribute;
  String condition;
  dynamic value;
  QueryFilter(
      {@required this.attribute,
      @required this.condition,
      @required this.value});
}

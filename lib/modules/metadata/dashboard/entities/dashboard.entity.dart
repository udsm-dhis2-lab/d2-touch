import 'package:dhis2_flutter_sdk/core/annotations/table_column.annotation.dart';
import 'package:flutter/material.dart';

class Dashboard {
  @TableColumn(type: 'varchar', nullable: true)
  final String id;
  Dashboard({@required String this.id});
}

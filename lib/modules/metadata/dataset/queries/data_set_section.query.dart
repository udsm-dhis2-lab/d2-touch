// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataSetSectionQuery extends BaseQuery<DataSetSection> {
  DataSetSectionQuery({Database? database}) : super(database: database);
}

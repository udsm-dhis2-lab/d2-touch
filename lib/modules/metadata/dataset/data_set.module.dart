import 'package:d2_touch/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element_option.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/validation_rule.query.dart';
import 'package:sqflite/sqflite.dart';

class DataSetModule {
  static createTables({required Database database}) async {
    await DataSetQuery(database: database).createTable();
    await DataSetElementQuery(database: database).createTable();
    await DataSetElementOptionQuery(database: database).createTable();
    await ValidationRuleQuery(database: database).createTable();
  }

  DataSetQuery get dataSet => DataSetQuery();

  DataSetElementQuery get dataSetElement => DataSetElementQuery();

  DataSetElementOptionQuery get dataSetElementOption =>
      DataSetElementOptionQuery();

  ValidationRuleQuery get validationRule => ValidationRuleQuery();
}

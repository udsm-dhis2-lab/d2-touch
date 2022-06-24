import 'package:d2_touch/modules/metadata/option_set/queries/option_set.query.dart';

class OptionSetModule {
  static createTables() async {
    await OptionSetQuery().createTable();
  }

  OptionSetQuery get optionSetQuery => OptionSetQuery();
}

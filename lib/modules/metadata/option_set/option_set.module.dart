import 'package:dhis2_flutter_sdk/modules/metadata/option_set/queries/option.query.dart';
import 'package:dhis2_flutter_sdk/modules/metadata/option_set/queries/option_set.query.dart';

class OptionSetModule {
  static createTables() async {
    await OptionQuery().createTable();
    await OptionSetQuery().createTable();
  }

  OptionQuery get optionQuery => OptionQuery();

  OptionSetQuery get optionSetQuery => OptionSetQuery();
}

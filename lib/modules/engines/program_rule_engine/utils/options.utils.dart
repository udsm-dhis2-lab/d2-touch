import "../interfaces/rules_engine.types.dart" show Option;

final getoptionSetCode = (List<Option> options, String key) {
  if (options) {
    final option = options.find((o) => identical(o.displayName, key));
    return (option && option.code) || key;
  }
  return key;
};
final getoptionSetName = (List<Option> options, String key) {
  if (options) {
    final option = options.find((o) => identical(o.code, key));
    return (option && option.displayName) || key;
  }
  return key;
};

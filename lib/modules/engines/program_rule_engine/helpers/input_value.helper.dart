import "package:moment.dart" as moment;
import "../interfaces/rules-engine.types.dart" show IConvertInputRulesValue;

const dateMomentFormat = "YYYY-MM-DD";
final dynamic functionConvertors = {
  "convertText": /* String */ (dynamic value) {
    return value || "";
  },
  "convertLongText": /* String */ (dynamic value) {
    return value || "";
  },
  "convertLetter": /* String */ (dynamic value) {
    return value || "";
  },
  "convertPhoneNumber": /* String */ (dynamic value) {
    return value || "";
  },
  "convertEmail": /* String */ (dynamic value) {
    return value || "";
  },
  "convertBoolean": /* dynamic /* bool | String */ */ (dynamic value) {
    return value || identical(value, false) ? value : "";
  },
  "convertTrueOnly": /* dynamic /* bool | String */ */ (dynamic value) {
    return value || identical(value, false) ? value : "";
  },
  "convertDate": /* String */ (dynamic value) {
    if (!value) {
      return "";
    }
    final momentObject = moment(value);
    return momentObject.format(dateMomentFormat);
  },
  "convertDateTime": /* String */ (dynamic value) {
    return value || "";
  },
  "convertTime": /* String */ (dynamic value) {
    return value || "";
  },
  "convertNumber": /* dynamic /* num | String */ */ (dynamic value) {
    return Number(value) || identical(value, 0) ? Number(value) : "";
  },
  "convertInteger": /* dynamic /* num | String */ */ (dynamic value) {
    return value || identical(value, 0) ? value : "";
  },
  "convertIntegerPositive": /* dynamic /* num | String */ */ (dynamic value) {
    return value || identical(value, 0) ? value : "";
  },
  "convertIntegerNegative": /* dynamic /* num | String */ */ (dynamic value) {
    return value || identical(value, 0) ? value : "";
  },
  "convertIntegerZeroOrPositive": /* dynamic /* num | String */ */ (dynamic value) {
    return value || identical(value, 0) ? value : "";
  },
  "convertPercentage": /* dynamic /* num | String */ */ (dynamic value) {
    return value || identical(value, 0) ? value : "";
  },
  "convertUrl": /* String */ (dynamic value) {
    return value || "";
  },
  "convertAge": /* String */ (dynamic value) {
    return functionConvertors.convertDate(value);
  }
};

import 'package:flutter_test/flutter_test.dart';

import 'package:dhis2_flutter_sdk/index.dart';

void main() {
  test('adds one to input values', () {
    final calculator = D2();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}

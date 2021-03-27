import 'package:flutter_test/flutter_test.dart';

import 'package:dhis2_flutter_sdk/index.dart';
import 'package:reflectable/reflectable.dart';

import 'index_test.reflectable.dart';

class MyReflectable extends Reflectable {
  const MyReflectable() : super(invokingCapability, metadataCapability);
}

const reflectable = MyReflectable();

@reflectable
class Dashboard {
  final String id;
  Dashboard({String this.id});
}

void main() {
  initializeReflectable();
  var ref = reflectable.reflectType(Dashboard);

  ref.metadata.forEach((element) {
    print(element);
  });

  test('adds one to input values', () {
    final calculator = D2();
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}

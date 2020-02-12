import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../keys/home_screen_keys.dart';

void homeScreenTest(FlutterDriver driver) {
  group("Example test group", () {
    test("Example test", () async {
      await driver.waitFor(HomeScreenKeys.apiExampleButton);
      await driver.tap(HomeScreenKeys.apiExampleButton);
    });
  });
}

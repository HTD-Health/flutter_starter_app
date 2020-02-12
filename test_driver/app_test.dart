import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'tests/home_screen_test.dart';

void main() async {
  FlutterDriver driver = await FlutterDriver.connect();

  homeScreenTest(driver);

  // Closing app after tests
  tearDownAll(() {
    driver.close();
  });
}

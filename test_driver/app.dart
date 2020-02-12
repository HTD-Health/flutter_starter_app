import 'package:flutter_starter_app/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  return runApp(MyApp(
    // without firebase analytics for testing
    analytics: null,
  ));
}

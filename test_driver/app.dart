import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_starter_app/config.dart';
import 'package:flutter_starter_app/start_app.dart';

void main() {
  enableFlutterDriverExtension();
  return startApp(AppConfig.development());
}

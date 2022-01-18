import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';

/// Base configuration class
abstract class Config {
  final List<DeviceOrientation> prefferedOrientations;
  final Style style;

  const Config({
    required this.prefferedOrientations,
    required this.style,
  });
}

/// Implement your config based on Config class
class AppConfig extends Config {
  final String apiUrl;

  AppConfig.development()
      : apiUrl = 'https://picsum.photos',
        super(
          prefferedOrientations: const [DeviceOrientation.portraitUp],
          style: Style(
            colors: const AppColors(
              accent: Colors.blueAccent,
              accent2: Colors.redAccent,
              content: Colors.black,
              content2: Colors.white,
              background: Colors.white,
              background2: Colors.black,
              shadow: Color.fromRGBO(0, 0, 0, 0.1),
              shadow2: Color.fromRGBO(0, 0, 0, 0.05),
            ),
          ),
        );

  /// TODO: Create other constructor / configuration for other enviroments
  ///
  /// For now dev configuration will be used for both
  ///
  /// ### TIP:
  /// You can also declare consturctors / configurations for other environments
  /// eg. `AppConfig.production`
  factory AppConfig.staging() = AppConfig.development;
}

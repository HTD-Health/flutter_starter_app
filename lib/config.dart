import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';

/// Base configuration class
abstract class Config {
  final List<DeviceOrientation> prefferedOrientations;
  final AppColors colors;

  const Config({
    @required this.prefferedOrientations,
    @required this.colors,
  }) : assert(colors != null, 'colors cannot be null');
}

/// Implement your config based on Config class
class AppConfig extends Config {
  final String apiUrl;

  const AppConfig.development()
      : apiUrl = 'https://picsum.photos',
        super(
          prefferedOrientations: const [DeviceOrientation.portraitUp],
          colors: const AppColors(
            accent: Colors.redAccent,
            secondaryAccent: Colors.blueAccent,
            content: Colors.black,
            secondaryContent: Colors.white,
            background: Colors.white,
            secondaryBackground: Colors.black,
            shadow: Color.fromRGBO(0, 0, 0, 0.1),
            secondaryShadow: Color.fromRGBO(0, 0, 0, 0.05),
          ),
        );

  /// TODO: Create other constructor / configuration for other enviroments
  ///
  /// For now dev configuration will be used for both
  ///
  /// ### TIP:
  /// You can also declare consturctors / configurations for other environments
  /// eg. `AppConfig.production`
  const factory AppConfig.staging() = AppConfig.development;
}

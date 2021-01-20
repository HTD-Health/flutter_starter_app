import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'config.dart';

/// Here you can provide your app-specific config and
/// therefore customize your app based on it.
///
/// ### TIP:
/// It could be helpful for app flavours implementation.
///
/// ### Example:
/// To run dev app use:
/// ```
/// flutter run
/// ```
/// To run app with staging configuration use
/// ```
/// flutter run -t lib/main_staging.dart
/// ```
void startApp(Config config) {
  WidgetsFlutterBinding.ensureInitialized();

  /// App supported orientations init
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      // Firebase analystics setup
      final analytics = FirebaseAnalytics();

      // Whether to send reports during development
      Crashlytics.instance.enableInDevMode = false;

      // It automatically prints errors to the console
      FlutterError.onError = Crashlytics.instance.recordFlutterError;

      runApp(App(
        analytics: analytics,
        config: config,
      ));
    },
  );
}

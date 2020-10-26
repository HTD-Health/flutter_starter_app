import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter_app/bloc/example_bloc.dart';
import 'package:flutter_starter_app/config.dart';
import 'package:flutter_starter_app/utils/api/api.dart';
import 'package:flutter_starter_app/utils/api/links/auth_link.dart';
import 'package:flutter_starter_app/utils/navigation/generate_route.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:http_api/http_api.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class App extends StatelessWidget {
  final AppConfig config;
  final FirebaseAnalytics analytics;

  App({
    @required this.analytics,
    @required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Style(
        child: MaterialApp(
          supportedLocales: const <Locale>[
            Locale('en'),
          ],
          title: 'FlutterStarter',
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(
                fallbackFile: 'en',
                useCountryCode: false,
                basePath: 'assets/i18n',
              ),
            ),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: config.colors.primarySwatch,
            accentColor: config.colors.accent,
            appBarTheme: AppBarTheme(color: config.colors.accent),
            backgroundColor: config.colors.background,
            dialogBackgroundColor: config.colors.background,
            scaffoldBackgroundColor: config.colors.background,
          ),
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.home,
        ),
        colors: config.colors,
      ),
      providers: <SingleChildWidget>[
        Provider(
          create: (_) => Api(
            url: Uri.parse(config.apiUrl),

            /// This header will be retrived from response and send back
            /// with next request
            link: AuthLink('access-token')

                /// Eesponsible for api request and response console prints
                .chain(LoggerLink(
                  url: true,
                  statusCode: true,
                  responseBody: true,
                ))

                /// Lats link should be a [HttpLink]. It is responsible for
                /// api requests
                .chain(HttpLink()),
          ),
        ),

        /// Provide blocs that will be used for state management
        ChangeNotifierProvider<ExampleBloc>(
          create: (_) => ExampleBloc(),
        ),
      ],
    );
  }
}

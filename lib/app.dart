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
import 'package:google_fonts/google_fonts.dart';
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
    final colors = config.style.colors;
    return MultiProvider(
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
          /// Sets custom app font
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          primarySwatch: colors.primarySwatch,
          accentColor: colors.accent,
          appBarTheme: AppBarTheme(color: colors.accent),
          backgroundColor: colors.background,
          dialogBackgroundColor: colors.background,
          scaffoldBackgroundColor: colors.background,
        ),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.home,
      ),
      providers: <SingleChildWidget>[
        Provider<Style>.value(value: config.style),
        Provider(
          create: (_) => Api(
            url: Uri.parse(config.apiUrl),

            /// This header will be retrived from response and send back
            /// with next request
            link: AuthLink('Authorization')

                /// Responsible for api request and response prints
                .chain(LoggerLink(
                  endpoint: true,
                  responseDuration: true,
                  requestBody: true,
                  statusCode: true,
                ))

                /// Links chain ends on [HttpLink]
                /// which makes an HTTP request.
                .chain(HttpLink()),
            defaultHeaders: const <String, String>{
              'organization_slug': 'silvercross',
              'Content-Type': 'application/json',
            },
          ),
        ),

        /// Provide blocs that will be used for state management.
        ChangeNotifierProvider<ExampleBloc>(
          create: (_) => ExampleBloc(),
        ),
      ],
    );
  }
}

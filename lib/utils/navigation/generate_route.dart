import 'package:flutter_starter_app/screens/api_example_screen/api_example_screen.dart';
import 'package:flutter_starter_app/screens/bloc_example_screen/bloc_example_screen.dart';
import 'package:flutter_starter_app/screens/example_home_screen/example_home_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const home = '/';
  static const blocExample = '/bloc_example';
  static const apiExample = '/api_example';
  // static const screenName = '/screenName';

  static Route<void> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<void>(builder: (_) => ExampleHomeScreen());
      case blocExample:
        return MaterialPageRoute<void>(builder: (_) => BlocExampleScreen());
      case apiExample:
        return MaterialPageRoute<void>(builder: (_) => ApiExampleScreen());
      // case screenName:
      // return MaterialPageRoute(builder: (_) => MyScreen());
      default:
        throw Exception("No route defined for \"${settings.name}\"");
    }
  }
}

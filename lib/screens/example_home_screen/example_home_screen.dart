import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_starter_app/utils/navigation/generate_route.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = context.watch<Style>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example home screen'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            RaisedButton(
              key: const ValueKey<String>('homeSceenApiExampleButton'),
              color: style.colors.accent,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.apiExample),
              child: Text(
                FlutterI18n.translate(context, 'home_screen.api_example'),
                style: style.fonts.normal,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              color: style.colors.accent,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.blocExample),
              child: Text(
                FlutterI18n.translate(context, 'home_screen.bloc_example'),
                style: style.fonts.normal,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              color: style.colors.accent,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.controllerExample),
              child: Text(
                FlutterI18n.translate(
                  context,
                  'home_screen.controller_example',
                ),
                style: style.fonts.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

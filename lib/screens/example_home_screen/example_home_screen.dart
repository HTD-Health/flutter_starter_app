import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_starter_app/utils/navigation/generate_route.dart';
import 'package:flutter_starter_app/utils/style_provider/style_provider.dart';
import 'package:flutter/material.dart';

class ExampleHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example home screen"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            RaisedButton(
              color: StyleProvider.of(context).colors.accent,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.apiExample),
              child: Text(
                FlutterI18n.translate(context, "home_screen.api_example"),
                style: StyleProvider.of(context).font.normal,
              ),
            ),
            const SizedBox(height: 15),
            RaisedButton(
              color: StyleProvider.of(context).colors.accent,
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.blocExample),
              child: Text(
                FlutterI18n.translate(context, "home_screen.bloc_example"),
                style: StyleProvider.of(context).font.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}

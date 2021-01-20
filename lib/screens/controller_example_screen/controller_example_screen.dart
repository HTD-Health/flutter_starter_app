import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/screens/controller_example_screen/controller.dart';
import 'package:flutter_starter_app/utils/controlled/controlled.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:provider/provider.dart';

class ControllerExampleScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final style = context.watch<Style>();
    return Controlled<CounterScreenController>(
      create: (context) => CounterScreenController(0),
      builder: (context, controller) => Scaffold(
        appBar: AppBar(
          title: Text(FlutterI18n.translate(
            context,
            'controller_example.title',
          )),
        ),
        body: Center(
          child: Text(
            controller.value.toString(),
            style: TextStyle(
              color: style.colors.content,
              fontSize: 46,
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'FAB1',
              onPressed: controller.increment,
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              // Clear bloc data
              heroTag: 'FAB2',
              onPressed: controller.decrement,
              backgroundColor: context.watch<Style>().colors.accent2,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}

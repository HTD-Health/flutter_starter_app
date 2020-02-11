import 'dart:math';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_starter_app/bloc/example_bloc.dart';
import 'package:flutter_starter_app/screens/bloc_example_screen/widgets/example_button/example_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:provider/provider.dart';

class BlocExampleScreen extends StatefulWidget {
  @override
  _BlocExampleScreenState createState() => _BlocExampleScreenState();
}

class _BlocExampleScreenState extends State<BlocExampleScreen> {
  @override
  Widget build(BuildContext context) {
    /// To improve performance try using Consumer or/and Selector widget
    /// More info in `README` file
    ExampleBloc bloc = Provider.of<ExampleBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          "bloc_example_screen.title",
        )),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (BuildContext context, int index) {
          final item = bloc.items[index];
          return ExampleButton(
            label: FlutterI18n.translate(
              context,
              "bloc_example_screen.click_to_delete",
            ),
            onPressed: () => bloc.removeAt(index),
            color: item.color,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        itemCount: bloc.items.length,
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "FAB1",
            onPressed: () => bloc.addItem(
              // Create new item with random color and add it to the BloC
              Item(Color(0xFF000000 + Random().nextInt(0xFFFFFFFF))),
            ),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            // Clear bloc data
            heroTag: "FAB2",
            onPressed: bloc.clear,
            backgroundColor: Style.of(context).colors.secondaryAccent,
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_starter_app/utils/api/api.dart';
import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/utils/style_provider/style.dart';
import 'package:restui/restui.dart';

class ApiExampleScreen extends StatefulWidget {
  @override
  _ApiExampleScreenState createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  final GlobalKey<QueryState<Api, ExamplePhotoModel, void>> _queryKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          "api_example_screen.title",
        )),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(
                    context,
                    "api_example_screen.fetched_only_once",
                  ),
                  style: Style.of(context).font.normal.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Query<Api, ExamplePhotoModel, void>(
                  key: _queryKey,
                  variable: 2,
                  callBuilder: (BuildContext context, Api api, _) =>
                      api.photos.getRandom(),
                  builder: (context, loading, photo) {
                    return Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: photo == null || loading
                          ? CircularProgressIndicator()
                          : Image.network(photo.lowQualityImageUrl),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  FlutterI18n.translate(
                    context,
                    "api_example_screen.fetched_every_10s",
                  ),
                  style: Style.of(context).font.normal.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Query<Api, ExamplePhotoModel, void>(
                  interval: const Duration(seconds: 10),
                  onComplete: (BuildContext context, ExamplePhotoModel photo) {
                    print("COMPLETE: ${photo.author}");
                  },
                  callBuilder: (BuildContext context, Api api, _) =>
                      api.photos.getRandom(),
                  builder: (context, loading, photo) {
                    return Container(
                      alignment: Alignment.center,
                      height: 200,
                      child: photo == null || loading
                          ? CircularProgressIndicator()
                          : Image.network(photo.lowQualityImageUrl),
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _queryKey.currentState.call(),
      ),
    );
  }
}

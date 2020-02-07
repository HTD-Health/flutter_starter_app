import 'package:flutter_starter_app/utils/api/api.dart';
import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';
import 'package:flutter_starter_app/utils/style_provider/style_provider.dart';
import 'package:flutter/material.dart';
import 'package:restui/restui.dart';

class ApiExampleScreen extends StatefulWidget {
  @override
  _ApiExampleScreenState createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  final GlobalKey<QueryState<ExamplePhotoModel, Api>> _queryKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api example"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "This image is fetched only once"
                  "can be refetched by pressing FAB button:",
                  style: StyleProvider.of(context)
                      .font
                      .normal
                      .copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Query<ExamplePhotoModel, Api>(
                  key: _queryKey,
                  callBuilder: (BuildContext context, Api api) =>
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
                  "This image is fetched every 10 seconds:",
                  style: StyleProvider.of(context)
                      .font
                      .normal
                      .copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Query<ExamplePhotoModel, Api>(
                  interval: const Duration(seconds: 10),
                  onComplete: (BuildContext context, ExamplePhotoModel photo) {
                    print("COMPLETE: ${photo.author}");
                  },
                  callBuilder: (BuildContext context, Api api) =>
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

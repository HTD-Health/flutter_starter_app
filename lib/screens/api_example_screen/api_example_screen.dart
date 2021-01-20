import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/api/api.dart';
import '../../utils/api/models/example_photo_model.dart';

class ApiExampleScreen extends StatefulWidget {
  @override
  _ApiExampleScreenState createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  ExamplePhotoModel _currentPhoto;
  bool _loading = false;

  @override
  void didChangeDependencies() {
    if (_currentPhoto == null) _fetchPhoto();

    super.didChangeDependencies();
  }

  Future<void> _fetchPhoto() async {
    if (_loading) return;
    setState(() {
      _loading = true;
    });

    final api = Provider.of<Api>(context, listen: false);
    final randomPhoto = await api.photos.getRandom();

    setState(() {
      _loading = false;
      _currentPhoto = randomPhoto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(
          context,
          'api_example_screen.title',
        )),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            Container(
              height: 300,
              color: Colors.black12,
              child: _currentPhoto != null && !_loading
                  ? Image.network(
                      _currentPhoto.downloadUrl,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
      floatingActionButton: _loading
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: _fetchPhoto,
            ),
    );
  }
}

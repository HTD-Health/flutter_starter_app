import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';

class Api {
  Dio client;
  _PhotoQueries? _photos;
  _PhotoQueries? get photos => _photos;

  Api({
    required Uri url,
    Map<String, String>? defaultHeaders,
  }) : client = Dio(
          BaseOptions(
            baseUrl: url.toString(),
            connectTimeout: 5000,
            receiveTimeout: 3000,
            headers: defaultHeaders,
          ),
        ) {
    _photos = _PhotoQueries(client);
  }
}

class _PhotoQueries {
  Dio client;
  _PhotoQueries(this.client);

  Future<ExamplePhotoModel> getRandom() async {
    final index = Random().nextInt(50);
    final response = await client.get<dynamic>(
      '/id/${index}/info',
    );
    return ExamplePhotoModel.fromJson(response.data);
  }
}

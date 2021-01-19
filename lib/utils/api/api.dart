import 'dart:convert';
import 'dart:math';

import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http_api/http_api.dart';

class Api extends BaseApi with Cache {
  _PhotoQueries _photos;
  _PhotoQueries get photos => _photos;

  Api({
    ApiLink link,
    @required Uri url,
    Map<String, String> defaultHeaders,
  }) : super(url, defaultHeaders: defaultHeaders, link: link) {
    _photos = _PhotoQueries(this);
  }

  /// Creates a cache menager that will cache requests and responses
  /// in the memory.
  @override
  CacheManager createCacheManager() => InMemoryCache();
}

class _PhotoQueries {
  Api api;
  _PhotoQueries(this.api);

  Future<ExamplePhotoModel> getPhoto(int index) async {
    /// Retrieve request from the cache if available otherwise from the network.
    final response = await api.cacheIfAvailable(
      Request(
        endpoint: '/id/${index}/info',

        /// The response will be cached under the following key.
        key: CacheKey('getPhoto($index)'),
      ),
    );
    return ExamplePhotoModel.fromJson(json.decode(response.body));
  }

  Future<ExamplePhotoModel> getRandom() async {
    final index = Random().nextInt(50);
    final response = await api.send(Request(
      endpoint: '/id/${index}/info',

      /// Cache response under the following key.
      key: CacheKey('getPhoto($index)'),
    ));
    return ExamplePhotoModel.fromJson(json.decode(response.body));
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http_api/http_api.dart';

class Api extends BaseApi {
  _PhotoQueries _photos;
  _PhotoQueries get photos => _photos;

  Api({
    ApiLink link,
    @required Uri url,
    Map<String, String> defaultHeaders,
  }) : super(url: url, defaultHeaders: defaultHeaders, link: link) {
    _photos = _PhotoQueries(this);
  }
}

class _PhotoQueries {
  Api api;
  _PhotoQueries(this.api);

  Future<ExamplePhotoModel> getRandom() async {
    final response = await api.send(ApiRequest(
      endpoint: '/id/${Random().nextInt(50)}/info',
      method: HttpMethod.get,
    ));
    return ExamplePhotoModel.fromJson(json.decode(response.body));
  }
}

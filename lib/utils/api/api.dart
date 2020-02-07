import 'dart:convert';
import 'dart:math';

import 'package:flutter_starter_app/utils/api/models/example_photo_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:restui/restui.dart';

class Api extends ApiBase {
  _PhotoQueries _photos;
  _PhotoQueries get photos => _photos;

  Api({
    ApiLink link,
    @required Uri uri,
    Map<String, String> defaultHeaders,
  }) : super(uri: uri, defaultHeaders: defaultHeaders, link: link) {
    _photos = _PhotoQueries(this);
  }
}

class _PhotoQueries {
  Api api;
  _PhotoQueries(this.api);

  Future<ExamplePhotoModel> getRandom() async {
    final response = await api.call(
      endpoint: "/id/${Random().nextInt(50)}/info",
      method: HttpMethod.GET,
    );
    return ExamplePhotoModel.fromJson(json.decode(response.body));
  }
}

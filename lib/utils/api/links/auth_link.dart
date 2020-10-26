import 'package:http_api/http_api.dart';

class AuthLink extends ApiLink {
  final bool canUpdateToken;
  final String authHeaderName;
  String authToken;

  AuthLink(this.authHeaderName, {String token, this.canUpdateToken = true}) {
    authToken ??= token;
  }

  void removeSession() {
    authToken = null;
  }

  Future<void> _setHeader(Map<String, String> headers) async {
    if (headers == null) return;
    final value = headers[authHeaderName];
    if (value == null) return;
    authToken = value;
  }

  @override
  Future<ApiResponse> next(ApiRequest request) async {
    if (authToken != null) request.headers[authHeaderName] = authToken;

    ApiResponse response = await super.next(request);
    if (canUpdateToken) _setHeader(response.headers);
    return response;
  }

  @override
  String toString() => '$runtimeType(${authToken})';
}

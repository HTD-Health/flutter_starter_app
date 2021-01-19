import 'package:http_api/http_api.dart';

/// Provides received [headerName] header with next requests.
class AuthLink extends ApiLink {
  final bool canUpdateHeader;
  final String headerName;
  String value;

  AuthLink(this.headerName, {this.value, this.canUpdateHeader = true});

  /// Remove value
  void clear() {
    value = null;
  }

  Future<void> _setValueFromResponseHeaders(Map<String, String> headers) async {
    if (headers == null) return;
    final headerValue = headers[headerName];
    if (headerValue == null) return;
    value = headerValue;
  }

  @override
  Future<Response> next(Request request) async {
    if (value != null) request.headers[headerName] = value;

    final Response response = await super.next(request);
    if (canUpdateHeader) _setValueFromResponseHeaders(response.headers);
    return response;
  }

  @override
  String toString() => '$runtimeType(${value})';
}

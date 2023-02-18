import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:orioks/api/api_constants.dart';

class UserAgentClient extends http.BaseClient {
  final userAgent = ApiConstants.userAgent;
  final http.Client _inner;

  UserAgentClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers[HttpHeaders.userAgentHeader] = userAgent;
    return _inner.send(request);
  }
}

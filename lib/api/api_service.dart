import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:orioks/api/api_constants.dart';
import 'package:orioks/api/user_agent_client.dart';
import 'package:orioks/datamodel/token.dart';

class ApiService {
  static UserAgentClient client = UserAgentClient(http.Client());

  static Future<Token> fetchToken(String login, String password) async {
    final String credentials = '$login:$password';
    var stringToBase64 = utf8.fuse(base64);
    var encodedCredentials = stringToBase64.encode(credentials);

    var logger = Logger();
    logger.d("Trying to get token");
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.authEndpoint);
    final response = await client.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Basic $encodedCredentials",
        HttpHeaders.acceptHeader: "application/json",
      },
    );
    logger.d(response.headers);
    logger.d(response.body);
    logger.close();
    if (response.statusCode == 200) {
      return Token.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to fetch token, status code: ${response.statusCode}, response body: ${response.body}");
    }
  }
}

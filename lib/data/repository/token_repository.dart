import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:orioks/data/api/api_service.dart';

import '../model/token.dart';

class TokenRepository {
  final _key = "token";
  final _storage = const FlutterSecureStorage();

  static final TokenRepository _instance = TokenRepository._();

  TokenRepository._();

  factory TokenRepository() => _instance;

  Future<Token> get({String? login, String? password}) async {
    String? token = await _storage.read(key: _key);
    if (token != null) {
      return Token(token);
    } else if (login != null && password != null) {
      final String credentials = '$login:$password';
      var stringToBase64 = utf8.fuse(base64);
      var encodedCredentials = stringToBase64.encode(credentials);

      String json = await ApiService().fetchToken(encodedCredentials);
      await _write(Token.fromJson(jsonDecode(json)));
      token = await _storage.read(key: _key);
      return Token(token!);
    } else {
      throw Exception("Failed to fetch token");
    }
  }

  Future<void> _write(Token token) =>
      _storage.write(key: _key, value: token.token);

  Future<List<Token>> getAllTokens() async {
    String response = await ApiService().fetchTokens();
    List<dynamic> json = jsonDecode(response);
    var tokens = List<Token>.from(json.map((e) => Token.fromJson(e)));
    tokens
        .sort((a, b) => a.lastUsed?.compareTo(b.lastUsed ?? DateTime(0)) ?? 0);
    return tokens;
  }
}

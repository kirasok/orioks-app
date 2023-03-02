import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  String token;
  Token(this.token);
  static fromJson(Map<String, dynamic> json) => Token(json['token']);
}

class TokenRepository {
  static const _key = "token";
  static const _storage = FlutterSecureStorage();
  static Future<Token?> read() async {
    String? token = await _storage.read(key: _key);
    if (token == null) {
      return null;
    } else {
      return Token(token);
    }
  }

  static Future<void> write(Token token) =>
      _storage.write(key: _key, value: token.token);
}

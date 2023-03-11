class Token {
  String token;
  DateTime? lastUsed;
  String? userAgent;
  Token(this.token, {this.lastUsed, this.userAgent});
  static fromJson(Map<String, dynamic> json) => Token(
        json['token'],
        lastUsed: DateTime.tryParse(json['last_used']),
        userAgent: json['user_agent'],
      );
}

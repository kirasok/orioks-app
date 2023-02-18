class Token {
  String token;
  Token(this.token);
  static fromJson(Map<String, dynamic> json) => Token(json['token']);
}

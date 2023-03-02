class Group {
  Group({
    required int id,
    required String name,
  });
  static fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
      );
}

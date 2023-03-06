class Group {
  int id;
  String name;

  Group({
    required this.id,
    required this.name,
  });
  static fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
      );
}

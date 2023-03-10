class Event {
  String? alias;
  num? currentGrade;
  num maxGrade;
  String? name;
  String type;
  num week;

  Event(
      {required this.alias,
      required this.currentGrade,
      required this.maxGrade,
      required this.name,
      required this.type,
      required this.week});

  static Event fromJson(Map<String, dynamic> json) => Event(
        alias: json['alias'],
        currentGrade: json['current_grade'],
        maxGrade: json['max_grade'],
        name: json['name'],
        type: json['type'],
        week: json['week'],
      );
}

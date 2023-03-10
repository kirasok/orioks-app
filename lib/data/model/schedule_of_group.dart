class ScheduleItem {
  String name;
  String type;
  num day;
  num pair;
  num week;
  num weekRecurrence;
  String location;
  String teacher;

  ScheduleItem({
    required this.name,
    required this.type,
    required this.day,
    required this.pair,
    required this.week,
    required this.weekRecurrence,
    required this.location,
    required this.teacher,
  });

  static ScheduleItem fromJson(Map<String, dynamic> json) => ScheduleItem(
        name: json['name'],
        type: json['type'],
        day: json['day'],
        pair: json['class'],
        week: json['week'],
        weekRecurrence: json['week_recurrence'],
        location: json['location'],
        teacher: json['teacher'],
      );
}

class ScheduleOfGroup {
  List<ScheduleItem> pairs;
  ScheduleOfGroup(this.pairs);
}

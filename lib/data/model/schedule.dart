class Schedule {
  DateTime semesterStart;
  DateTime sessionStart;
  DateTime sessionEnd;
  DateTime nextSemesterStart;

  Schedule({
    required this.semesterStart,
    required this.sessionStart,
    required this.sessionEnd,
    required this.nextSemesterStart,
  });
  static Schedule fromJson(Map<String, dynamic> json) => Schedule(
        semesterStart: DateTime.parse(json['semester_start']),
        sessionStart: DateTime.parse(json["session_start"]),
        sessionEnd: DateTime.parse(json["session_end"]),
        nextSemesterStart: DateTime.parse(json["next_semester_start"]),
      );
}

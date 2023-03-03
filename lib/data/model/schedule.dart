class Schedule {
  Schedule({
    required DateTime semesterStart,
    required DateTime sessionStart,
    required DateTime sessionEnd,
    required DateTime nextSemesterStart,
  });
  static Schedule fromJson(Map<String, dynamic> json) => Schedule(
        semesterStart: DateTime.parse(json['semester_start']),
        sessionStart: DateTime.parse(json["session_start"]),
        sessionEnd: DateTime.parse(json["session_end"]),
        nextSemesterStart: DateTime.parse(json["next_semester_start"]),
      );
}

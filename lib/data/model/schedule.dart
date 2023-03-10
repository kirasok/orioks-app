class Schedule {
  DateTime? semesterStart;
  DateTime? sessionStart;
  DateTime? sessionEnd;
  DateTime? nextSemesterStart;

  Schedule({
    required this.semesterStart,
    required this.sessionStart,
    required this.sessionEnd,
    required this.nextSemesterStart,
  });
  static Schedule fromJson(Map<String, dynamic> json) => Schedule(
        semesterStart: DateTime.tryParse(json['semester_start']),
        sessionStart: DateTime.tryParse(json["session_start"]),
        sessionEnd: DateTime.tryParse(json["session_end"]),
        nextSemesterStart: DateTime.tryParse(json["next_semester_start"]),
      );
}

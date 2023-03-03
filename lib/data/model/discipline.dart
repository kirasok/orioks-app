class Discipline {
  Discipline({
    required String controlForm,
    required double currentGrade,
    required String departament,
    required DateTime examDate,
    required int id,
    required double maxGrade,
    required String name,
    required List<String> teachers,
  });
  static Discipline fromJson(Map<String, dynamic> json) => Discipline(
        controlForm: json["control_form"],
        currentGrade: json["current_grade"],
        departament: json["department"],
        examDate: DateTime.parse(json["exam_date"]),
        id: json["id"],
        maxGrade: json["max_grade"],
        name: json["name"],
        teachers: json["teachers"],
      );
}

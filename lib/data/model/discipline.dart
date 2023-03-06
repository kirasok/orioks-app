class Discipline {
  String controlForm;
  double currentGrade;
  String departament;
  DateTime examDate;
  int id;
  double maxGrade;
  String name;
  List<String> teachers;

  Discipline({
    required this.controlForm,
    required this.currentGrade,
    required this.departament,
    required this.examDate,
    required this.id,
    required this.maxGrade,
    required this.name,
    required this.teachers,
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

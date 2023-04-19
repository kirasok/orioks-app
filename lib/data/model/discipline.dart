class Discipline {
  String controlForm;
  num currentGrade;
  String departament;
  DateTime? examDate;
  int id;
  num maxGrade;
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
  static Discipline fromJson(Map<String, dynamic> json) {
    return Discipline(
      controlForm: json["control_form"],
      currentGrade: json["current_grade"] as num,
      departament: json["department"],
      examDate: DateTime.tryParse(json["exam_date"]),
      id: json["id"],
      maxGrade: json["max_grade"] as num,
      name: json["name"],
      teachers: List<String>.from(json["teachers"] as List<dynamic>),
    );
  }
}

class Student {
  int course;
  String department;
  String fullName;
  String group;
  int recordBookId;
  int semester;
  String studyDirection;
  String studyProfile;
  String year;

  Student({
    required this.course,
    required this.department,
    required this.fullName,
    required this.group,
    required this.recordBookId,
    required this.semester,
    required this.studyDirection,
    required this.studyProfile,
    required this.year,
  });
  static Student fromJson(Map<String, dynamic> json) => Student(
      course: json['course'],
      department: json['department'],
      fullName: json['full_name'],
      group: json['group'],
      recordBookId: json['record_book_id'],
      semester: json['semester'],
      studyDirection: json['study_direction'],
      studyProfile: json['study_profile'],
      year: json['year']);
}

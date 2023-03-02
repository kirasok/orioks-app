class Student {
  Student({
    required int course,
    required String department,
    required String fullName,
    required String group,
    required int recordBookId,
    required int semester,
    required String studyDirection,
    required String studyProfile,
    required int year,
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

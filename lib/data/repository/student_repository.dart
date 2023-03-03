import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/student.dart';

class StudentRepository {
  static final StudentRepository _instance = StudentRepository._();

  StudentRepository._();

  factory StudentRepository() => _instance;

  Future<Student> get() async =>
      Student.fromJson(jsonDecode(await ApiService().fetchStudent()));
}

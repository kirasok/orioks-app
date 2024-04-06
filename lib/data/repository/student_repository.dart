import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentRepository {
  static final StudentRepository _instance = StudentRepository._();

  StudentRepository._();

  factory StudentRepository() => _instance;

  Future<Student> get() async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json = await rootBundle.loadString('assets/templates/basic/student.json');
    } else {
      json = await ApiService().fetchStudent();
    }
    return Student.fromJson(jsonDecode(json));
  }
}

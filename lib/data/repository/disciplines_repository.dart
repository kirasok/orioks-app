import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:orioks/constants.dart';
import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisciplinesRepository {
  static final DisciplinesRepository _instance = DisciplinesRepository._();

  DisciplinesRepository._();

  factory DisciplinesRepository() => _instance;

  Future<List<Discipline>> get() async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json = await rootBundle.loadString('templates/basic/disciplines.json');
    } else {
      json = await ApiService().fetchDisciplines();
    }
    final List<dynamic> dynamicList = jsonDecode(json);
    final List<Discipline> disciplines =
        List<Discipline>.from(dynamicList.map((e) => Discipline.fromJson(e)));
    return disciplines;
  }
}

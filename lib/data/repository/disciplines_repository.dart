import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/discipline.dart';

class DisciplinesRepository {
  static final DisciplinesRepository _instance = DisciplinesRepository._();

  DisciplinesRepository._();

  factory DisciplinesRepository() => _instance;

  Future<List<Discipline>> get() async {
    String json = await ApiService().fetchDisciplines();
    final List<dynamic> dynamicList = jsonDecode(json);
    final List<Discipline> disciplines =
        List<Discipline>.from(dynamicList.map((e) => Discipline.fromJson(e)));
    return disciplines;
  }
}

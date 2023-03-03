import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/timetable.dart';

class TimetableRepository {
  static final TimetableRepository _instance = TimetableRepository._();

  TimetableRepository._();

  factory TimetableRepository() => _instance;

  Future<Timetable> get() async =>
      Timetable.fromJson(jsonDecode(await ApiService().fetchTimetable()));
}

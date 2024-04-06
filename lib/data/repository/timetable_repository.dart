import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/timetable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableRepository {
  static final TimetableRepository _instance = TimetableRepository._();

  TimetableRepository._();

  factory TimetableRepository() => _instance;

  Future<Timetable> get() async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json =
          await rootBundle.loadString('assets/templates/basic/timetable.json');
    } else {
      json = await ApiService().fetchTimetable();
    }
    return Timetable.fromJson(jsonDecode(json));
  }
}

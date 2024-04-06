import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleRepository {
  static final ScheduleRepository _instance = ScheduleRepository._();

  ScheduleRepository._();

  factory ScheduleRepository() => _instance;

  Future<Schedule> get() async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json =
          await rootBundle.loadString('assets/templates/basic/schedule.json');
    } else {
      json = await ApiService().fetchSchedule();
    }
    return Schedule.fromJson(jsonDecode(json));
  }
}

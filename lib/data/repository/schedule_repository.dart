import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/schedule.dart';

class ScheduleRepository {
  static final ScheduleRepository _instance = ScheduleRepository._();

  ScheduleRepository._();

  factory ScheduleRepository() => _instance;

  Future<Schedule> get() async =>
      Schedule.fromJson(jsonDecode(await ApiService().fetchSchedule()));
}

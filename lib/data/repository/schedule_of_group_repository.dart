import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/schedule_of_group.dart';

class ScheduleOfGroupRepository {
  static final ScheduleOfGroupRepository _instance =
      ScheduleOfGroupRepository._();

  ScheduleOfGroupRepository._();

  factory ScheduleOfGroupRepository() => _instance;

  Future<ScheduleOfGroup> get(int groupId) async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json = await rootBundle
          .loadString('assets/templates/advanced/scheduleOfGroup.json');
    } else {
      json = await ApiService().fetchScheduleOfGroup(groupId);
    }
    List<dynamic> dynamicList = jsonDecode(json);
    return ScheduleOfGroup(
      List.from(
        dynamicList.map(
          (e) => ScheduleItem.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}

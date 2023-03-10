import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';

import '../model/schedule_of_group.dart';

class ScheduleOfGroupRepository {
  static final ScheduleOfGroupRepository _instance =
      ScheduleOfGroupRepository._();

  ScheduleOfGroupRepository._();

  factory ScheduleOfGroupRepository() => _instance;

  Future<ScheduleOfGroup> get(int groupId) async {
    String json = await ApiService().fetchScheduleOfGroup(groupId);
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

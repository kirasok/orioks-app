import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupsRepository {
  static final GroupsRepository _instance = GroupsRepository._();

  GroupsRepository._();

  factory GroupsRepository() => _instance;

  Future<List<Group>> get() async {
    String json;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      json = await rootBundle.loadString('templates/basic/groups.json');
    } else {
      json = await ApiService().fetchGroups();
    }
    final List<dynamic> dynamicList = jsonDecode(json);
    final List<Group> groups =
        List.from(dynamicList.map((e) => Group.fromJson(e)));
    return groups;
  }
}

import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';
import 'package:orioks/data/model/group.dart';

class GroupsRepository {
  static final GroupsRepository _instance = GroupsRepository._();

  GroupsRepository._();

  factory GroupsRepository() => _instance;

  Future<List<Group>> get() async {
    String json = await ApiService().fetchGroups();
    final List<dynamic> dynamicList = jsonDecode(json);
    final List<Group> groups =
        List.from(dynamicList.map((e) => Group.fromJson(e)));
    return groups;
  }
}

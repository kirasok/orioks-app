import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:orioks/constants.dart';

import 'package:orioks/data/api/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/event.dart';

class EventsRepository {
  static final EventsRepository _instance = EventsRepository._();

  EventsRepository._();

  factory EventsRepository() => _instance;

  Future<List<Event>> get(int disciplineId) async {
    String response;
    if ((await SharedPreferences.getInstance())
            .getBool(Constants.demoModeKey) ??
        false) {
      response = await rootBundle
          .loadString('assets/templates/advanced/events/$disciplineId.json');
    } else {
      response = await ApiService().fetchEvents(disciplineId);
    }
    List<dynamic> json = jsonDecode(response);
    var result = List<Event>.from(json.map((e) => Event.fromJson(e)));
    result.sort((a, b) => a.week.compareTo(b.week));
    return result;
  }
}

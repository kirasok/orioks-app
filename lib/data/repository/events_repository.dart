import 'dart:convert';

import 'package:orioks/data/api/api_service.dart';

import '../model/event.dart';

class EventsRepository {
  static final EventsRepository _instance = EventsRepository._();

  EventsRepository._();

  factory EventsRepository() => _instance;

  Future<List<Event>> get(int disciplineId) async {
    String response = await ApiService().fetchEvents(disciplineId);
    List<dynamic> json = jsonDecode(response);
    return List.from(json.map((e) => Event.fromJson(e)));
  }
}

import 'package:flutter/material.dart';

class Pair {
  late TimeOfDay start;
  late TimeOfDay end;
  Pair(String start, String end) {
    this.start = _parse(start);
    this.end = _parse(end);
  }

  TimeOfDay _parse(String time) {
    var parts = time.split(":");
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

class Timetable {
  Map<int, Pair> pairs;

  Timetable({
    required this.pairs,
  });

  static fromJson(Map<String, dynamic> json) => Timetable(
        pairs: json.map(
          (key, value) {
            var s = List<String>.from(value as List<dynamic>);
            Pair pair = Pair(s[0], s[1]);
            return MapEntry(int.parse(key), pair);
          },
        ),
      );
}

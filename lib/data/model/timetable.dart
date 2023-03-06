import 'package:flutter/material.dart';

class Timetable {
  Map<int, List<TimeOfDay>> pairs;

  Timetable({
    required this.pairs,
  });

  static fromJson(Map<String, dynamic> json) => json.map(
        (key, value) => MapEntry(
          int.parse(key),
          [
            TimeOfDay.fromDateTime(DateTime.parse(value[0])),
            TimeOfDay.fromDateTime(DateTime.parse(value[1]))
          ],
        ),
      );
}
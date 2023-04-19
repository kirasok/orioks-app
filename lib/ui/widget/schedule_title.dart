import 'package:flutter/material.dart';
import 'package:orioks/data/model/schedule_of_group.dart';
import 'package:orioks/data/model/timetable.dart';

class ScheduleTile extends StatelessWidget {
  final Timetable timetable;
  final ScheduleItem pair;

  const ScheduleTile({super.key, required this.timetable, required this.pair});

  @override
  Widget build(BuildContext context) {
    String type = pair.type != "" ? "(${pair.type})" : "";
    String start = "", end = "";
    if (timetable.pairs[pair.pair] != null) {
      final startTime = timetable.pairs[pair.pair]!.start;
      final endTime = timetable.pairs[pair.pair]!.end;
      start = startTime.format(context);
      end = endTime.format(context);
      final now = TimeOfDay.now();
      if (startTime.hour <= now.hour &&
          startTime.minute <= now.minute &&
          now.hour <= endTime.hour &&
          now.minute <= endTime.minute) {
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
          margin: const EdgeInsets.all(8),
          child: _buildTile(type, start, end),
        );
      }
    }
    return _buildTile(type, start, end);
  }

  Widget _buildTile(String type, String start, String end) => ListTile(
        title: Text("${pair.name} $type"),
        subtitle: Text(pair.teacher),
        leading: Text("$start\n$end"),
        trailing: Text(pair.location),
      );
}

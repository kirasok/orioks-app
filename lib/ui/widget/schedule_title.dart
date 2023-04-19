import 'package:flutter/material.dart';
import 'package:orioks/data/model/schedule_of_group.dart';
import 'package:orioks/data/model/timetable.dart';

class ScheduleTile extends StatelessWidget {
  final Timetable timetable;
  final ScheduleItem pair;

  const ScheduleTile({super.key, required this.timetable, required this.pair});

  @override
  Widget build(BuildContext context) {
    String type = "";
    if (pair.type != "") {
      type = "(${pair.type})";
    }
    String start = timetable.pairs[pair.pair]?.start.format(context) ?? "";
    String end = timetable.pairs[pair.pair]?.end.format(context) ?? "";
    return ListTile(
      title: Text("${pair.name} $type"),
      subtitle: Text(pair.teacher),
      leading: Text("$start\n$end"),
      trailing: Text(pair.location),
    );
  }
}

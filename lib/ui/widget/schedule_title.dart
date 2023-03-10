import 'package:flutter/material.dart';
import 'package:orioks/data/model/schedule_of_group.dart';
import 'package:orioks/data/model/timetable.dart';

class ScheduleTile extends StatelessWidget {
  final Timetable timetable;
  final ScheduleItem pair;

  const ScheduleTile({super.key, required this.timetable, required this.pair});

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text("${pair.name} (${pair.type})"),
        subtitle: Text(pair.teacher),
        leading: Text(
            "${timetable.pairs[pair.pair]?.start.format(context)}\n${timetable.pairs[pair.pair]?.end.format(context)}"),
        trailing: Text(pair.location),
      );
}

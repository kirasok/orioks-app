import 'package:flutter/material.dart';
import 'package:orioks/data/model/event.dart';
import 'package:orioks/ui/widget/grade.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 72,
        child: ListTile(
          leading: Grade(current: event.currentGrade ?? 0, max: event.maxGrade),
          title: Text(event.type),
          subtitle: event.name == null ? null : Text(event.name!),
          trailing: Text(event.week.toString()),
        ),
      );
}

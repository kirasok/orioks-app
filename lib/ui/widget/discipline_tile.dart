import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/logic/cubit/events_cubit.dart';
import 'package:orioks/ui/colors.dart';

import '../screen/events_screen.dart';

class DisciplineTile extends StatelessWidget {
  final Discipline discipline;

  const DisciplineTile({super.key, required this.discipline});

  @override
  Widget build(BuildContext context) {
    String grade = "-";
    if (discipline.currentGrade > 0) {
      grade = discipline.currentGrade.toString();
    }
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(5),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: gradeToColor(
              discipline.currentGrade, discipline.maxGrade, context),
        ),
        child: Center(
          child: Text(
            grade,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
      title: Text(discipline.name),
      subtitle: Text(discipline.controlForm),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<EventsCubit>(context),
              child: EventsScreen(
                disciplineName: discipline.name,
                disciplineId: discipline.id,
              ),
            ),
          ),
        );
      },
    );
  }
}

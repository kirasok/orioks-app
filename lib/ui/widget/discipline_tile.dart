import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/logic/cubit/events_cubit.dart';
import 'package:orioks/ui/screen/events_screen.dart';

import 'grade.dart';

class DisciplineTile extends StatelessWidget {
  final Discipline discipline;

  const DisciplineTile({super.key, required this.discipline});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Grade(
        current: discipline.currentGrade,
        max: discipline.maxGrade,
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

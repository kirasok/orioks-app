import 'package:flutter/material.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/ui/colors.dart';

class DisciplineTile extends StatelessWidget {
  final Discipline discipline;
  final VoidCallback onTap;

  const DisciplineTile(
      {super.key, required this.discipline, required this.onTap});

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
          color: gradeToColor(discipline.currentGrade, discipline.maxGrade),
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
      onTap: onTap,
    );
  }
}

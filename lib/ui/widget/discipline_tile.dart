import 'package:flutter/material.dart';
import 'package:orioks/data/model/discipline.dart';
import 'package:orioks/ui/colors.dart';

class DisciplineTile extends StatelessWidget {
  final Discipline _discipline;

  const DisciplineTile(this._discipline, {super.key});

  @override
  Widget build(BuildContext context) {
    String grade = "-";
    if (_discipline.currentGrade > 0) {
      grade = _discipline.currentGrade.toString();
    }
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(5),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: gradeToColor(_discipline.currentGrade, _discipline.maxGrade),
        ),
        child: Center(
          child: Text(
            grade,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
      title: Text(_discipline.name),
      subtitle: Text(_discipline.controlForm),
    );
  }
}

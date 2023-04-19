import 'package:flutter/material.dart';

import '../colors.dart';

class Grade extends StatelessWidget {
  final num current;
  final num max;

  const Grade({super.key, required this.current, required this.max});

  @override
  Widget build(BuildContext context) {
    String grade = "-";
    if (current > 0) {
      grade = current.toString();
    }
    return Container(
      padding: const EdgeInsets.all(5),
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: gradeToColor(current, max, context),
      ),
      child: Center(
        child: Text(
          "$grade/$max",
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

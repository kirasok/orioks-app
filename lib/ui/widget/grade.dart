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
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: gradeToColor(current, max),
      ),
      child: Center(
        child: Text(
          grade,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

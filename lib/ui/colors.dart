import 'package:flutter/material.dart';

List<num> _gradeZones = [0.0, 0.25, 0.5, 0.7, 0.85, 1.0];

var _gradeColors = [
  const Color(0x00ffffff),
  const Color(0xffe53935),
  const Color(0xffff9800),
  const Color(0xffffd54f),
  const Color(0xffcddc39),
  const Color(0xff66bb6a),
];

var _gradeColorsDark = [
  const Color(0x00ffffff),
  const Color(0xff93000d),
  const Color(0xff693c00),
  const Color(0xff574500),
  const Color(0xff444b00),
  const Color(0xff005318),
];

Color gradeToColor(num currentGrade, num maxGrade, BuildContext context) {
  int index =
      _gradeZones.indexWhere((element) => currentGrade <= maxGrade * element);
  return Theme.of(context).brightness == Brightness.light
      ? _gradeColors[index]
      : _gradeColorsDark[index];
}

const seedLight = Color(0xff008cba);

const seedDark = Color(0xff007095);

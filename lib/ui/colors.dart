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

Color gradeToColor(num currentGrade, num maxGrade) => _gradeColors[
    _gradeZones.indexWhere((element) => currentGrade <= maxGrade * element)];

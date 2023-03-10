import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

import 'ui/app.dart';

// TODO: check if it is neccessary to update schedule https://gitlab.com/orioks/student-api/-/blob/master/docs/schedule.rst
// TODO: fetch discipline's events using id of discipline https://gitlab.com/orioks/student-api/-/blob/master/docs/student/events.rst
// TODO: fetch resits using id of discipline https://gitlab.com/orioks/student-api/-/blob/master/docs/student/resits.rst
// TODO: push notifications api https://gitlab.com/orioks/student-api/-/blob/master/docs/student/pushes.rst
// TODO: allow to view and delete tokens https://gitlab.com/orioks/student-api/-/blob/master/docs/student/tokens.rst

// TODO: find a way to store data

// TODO: clean stream handling in cubits
// TODO: refactor int, double, num
// TODO: ensure consistency of variable's names

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
}

void main() {
  if (UniversalPlatform.isDesktop) setDesktopWindow();

  runApp(const MyApp());
}

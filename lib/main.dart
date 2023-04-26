import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:orioks/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

import 'ui/app.dart';

// TODO: fetch resits using id of discipline https://gitlab.com/orioks/student-api/-/blob/master/docs/student/resits.rst

Future setDesktopWindow() async {
  await DesktopWindow.setMinWindowSize(const Size(400, 400));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (UniversalPlatform.isDesktop) setDesktopWindow();

  runApp(const MyApp());

  var prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(Constants.demoModeKey) ?? false) {
    await prefs.clear();
  }
}

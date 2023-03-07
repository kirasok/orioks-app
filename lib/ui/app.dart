import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (light, dark) => MaterialApp(
        title: 'Orioks',
        theme: ThemeData(
          colorScheme: light ??
              ColorScheme.fromSeed(
                seedColor: const Color(0xff008cba),
                brightness: Brightness.light,
              ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: dark ??
              ColorScheme.fromSeed(
                seedColor: const Color(0xff007095),
                brightness: Brightness.dark,
              ),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Orioks'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text("UI is being developed"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orioks',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Orioks'),
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
  int _counter = 0;

  String _text = "Push the button!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _text,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      if (_counter >= 31) {
        _text = "I told you to stop, fucker!";
        return;
      }
      _counter++;
      if (_counter >= 30) {
        _text = "Oh! I can't take more! Enough!";
      } else if (_counter >= 20) {
        _text = "Eveeeen moooore!!!";
      } else if (_counter >= 10) {
        _text = "Push it even mooore!";
      } else if (_counter >= 3) {
        _text = "Yeah, push the button more!";
      }
    });
  }
}

import 'package:flutter/material.dart';
import 'package:orioks/data/repository/token_repository.dart';

// TODO: fetch schedule of group using id of student's group https://gitlab.com/orioks/student-api/-/blob/master/docs/schedule.rst
// TODO: check if it is neccessary to update schedule https://gitlab.com/orioks/student-api/-/blob/master/docs/schedule.rst
// TODO: fetch discipline's events using id of discipline https://gitlab.com/orioks/student-api/-/blob/master/docs/student/events.rst
// TODO: fetch resits using id of discipline https://gitlab.com/orioks/student-api/-/blob/master/docs/student/resits.rst
// TODO: push notifications api https://gitlab.com/orioks/student-api/-/blob/master/docs/student/pushes.rst
// TODO: allow to view and delete tokens https://gitlab.com/orioks/student-api/-/blob/master/docs/student/tokens.rst

// TODO: schedule of group datamodel
// TODO: find a way to store data

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
  String _token = "no token yet";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_token),
            ElevatedButton(
              onPressed: () async {
                _token = (await TokenRepository().get()).token;
                setState(() {});
              },
              child: const Text("Fetch token!"),
            )
          ],
        ),
      ),
    );
  }
}

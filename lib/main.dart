import 'package:flutter/material.dart';
import 'package:orioks/api/api_constants.dart';
import 'package:orioks/api/api_service.dart';
import 'package:orioks/datamodel/token.dart';

void main() {
  runApp(const MyApp());
  ApiService.client.close();
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
                _token = (await TokenRepository.read())?.token ?? "Empty";
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

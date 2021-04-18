import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anon-app',
      home: Scaffold(
        appBar: AppBar(title: Text("Anon")),
      ),
    );
  }
}

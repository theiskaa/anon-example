import 'package:flutter/material.dart';

import 'view/screens/auth.dart';
import 'view/widgets/anon_widgets.dart';

class App extends AnonStatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anon-app',
      home: AuthScreen(),
    );
  }
}

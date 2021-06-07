import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends AnonStatelessWidget {
  Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );

    return Container();
  }
}

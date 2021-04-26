import 'package:flutter/material.dart';

import 'home/home.dart';
import 'package:anon/view/widgets/anon_widgets.dart';

class MainPage extends AnonStatelessWidget {
  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // To make BottomNavigationBar without labels.
    // TODO: https://stackoverflow.com/a/60316654/14247462
    return Home();
  }
}

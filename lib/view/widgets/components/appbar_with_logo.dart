import 'package:flutter/material.dart';

import '../anon_widgets.dart';

class AppBarWithLogo extends AnonStatelessWidget with PreferredSizeWidget {
  final List<Widget> actions;

  AppBarWithLogo({
    Key key,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Image.asset(
        'assets/anon-text-logo.png',
        key: Key('anon.logo'),
        height: 35,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

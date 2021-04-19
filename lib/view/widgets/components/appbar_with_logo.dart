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
      centerTitle: true,
      elevation: 1,
      backgroundColor: Colors.grey[100],
      title: Image.asset(
        'assets/anon-logo.png',
        key: Key('anon.logo'),
        height: 35,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

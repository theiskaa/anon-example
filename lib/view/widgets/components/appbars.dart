import 'package:anon/view/widgets/components/opacity_button.dart';
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

class DefaultAppBar extends AnonStatelessWidget with PreferredSizeWidget {
  final Function onLeadingTap;
  final Widget centerWidget;
  final List<Widget> actions;

  DefaultAppBar({
    Key key,
    this.actions,
    this.centerWidget,
    this.onLeadingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: centerWidget,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
      leading: OpacityButton(
        key: Key("go.back.button"),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onTap: onLeadingTap ?? () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

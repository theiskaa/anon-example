import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbar_with_logo.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends AnonStatelessWidget {
  MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Center(
        child: Text("Nothin' for now :)"),
      ),
    );
  }

  AppBarWithLogo appbar(BuildContext context) {
    return AppBarWithLogo(
      actions: [logOutButton(context)],
    );
  }

  Padding logOutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: OpacityButton(
        key: Key('logout.button'),
        child: Icon(Icons.logout, color: Colors.black),
        onTap: () {
          BlocProvider.of<AuthBloc>(context).add(AuthEvent.logoutStart());
        },
      ),
    );
  }
}

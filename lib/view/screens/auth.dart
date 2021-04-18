import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/auth_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends AnonStatelessWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      bottomNavigationBar: authButton(),
    );
  }

  AuthButton authButton() {
    return AuthButton(
      key: Key('auth.button'),
      title: "Join now",
      onTap: () {},
    );
  }

  Center body() {
    return Center(
      child: Image.asset(
        'assets/anon-logo.png',
        key: Key("anon.logo"),
        height: 150,
      ),
    );
  }
}

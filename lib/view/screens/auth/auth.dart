import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/auth_button.dart';
import 'package:anon/view/widgets/loading.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends AnonStatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends AnonState<AuthScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading) ? Loading() : body(),
      bottomNavigationBar: authButton(context),
    );
  }

  AuthButton authButton(BuildContext context) {
    return AuthButton(
      key: Key('auth.button'),
      title: (loading) ? "Cancel" : "Join now",
      onTap: () {
        if (loading) {
          BlocProvider.of<AuthBloc>(context).add(AuthEvent.logoutStart());
          setState(() => loading = false);
        } else {
          BlocProvider.of<AuthBloc>(context).add(AuthEvent.signInStart());
          setState(() => loading = true);
        }
      },
    );
  }

  Center body() {
    return Center(
      child: OpacityAnimator(
        duration: Duration(seconds: 1),
        beginingOpacity: 0,
        child: Image.asset(
          'assets/anon-logo.png',
          key: Key("anon.logo"),
          height: 150,
        ),
      ),
    );
  }
}

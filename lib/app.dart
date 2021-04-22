import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/services/user_service.dart';
import 'package:anon/view/screens/auth/auth.dart';
import 'package:anon/view/screens/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/auth_service.dart';
import 'view/screens/pages/splash.dart';
import 'view/widgets/anon_widgets.dart';

class App extends AnonStatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends AnonState<App> {
  final _authService = AuthService();
  final _userService = UserService();

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(authService: _authService),
        ),
        BlocProvider<UserserviceBloc>(
          create: (context) => UserserviceBloc(userService: _userService)
            ..add(UserServiceEvent.getAllStart()),
        )
      ],
      child: repoProvider(),
    );
  }

  RepositoryProvider repoProvider() {
    return RepositoryProvider.value(
      value: _authService,
      child: RepositoryProvider.value(
        value: _userService,
        child: app(),
      ),
    );
  }

  MaterialApp app() {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anon-app',
      navigatorKey: _navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => Splash(),
      ),
      builder: (context, child) {
        return blocListener(child);
      },
    );
  }

  // Listens event type of bloc state and generating valid navigation.
  BlocListener<AuthBloc, AuthState> blocListener(Widget child) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.event) {
          case AuthEvents.authenticated:
            _navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (route) => false,
            );
            break;
          case AuthEvents.unauthenticated:
            _navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AuthScreen(),
              ),
              (route) => false,
            );
            break;
          default:
            _navigator.pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => AuthScreen(),
              ),
              (route) => false,
            );
        }
      },
      child: child,
    );
  }
}

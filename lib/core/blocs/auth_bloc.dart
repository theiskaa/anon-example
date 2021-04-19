import 'dart:async';

import 'package:anon/core/model/user.dart';
import 'package:anon/core/services/auth_service.dart';
import 'package:anon/core/system/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  StreamSubscription<UserModel> _userSubscription;

  AuthBloc({
    @required AuthService authService,
  })  : assert(authService != null),
        _authService = authService,
        super(AuthState.unknown()) {
    _userSubscription = _authService.user.listen(
      (user) => add(AuthEvent.authUserChanged(user)),
    );
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    switch (event.type) {
      case AuthEvents.authUserChanged:
        AuthState authState;
        if (event.user != UserModel.empty) {
          authState = state.copyWith(
            event: AuthEvents.authenticated,
            loading: false,
            user: event.user,
          );
        } else {
          authState = state.copyWith(
            event: AuthEvents.unauthenticated,
            loading: false,
          );
        }
        Log.d("U-ID: ${event.user.id}");
        yield authState;
        break;

      case AuthEvents.signInStart:
        AuthState authState;
        authState = state.copyWith(
          event: AuthEvents.signInStart,
          loading: true,
        );

        try {
          final authResult = await _authService.signIn();

          if (authResult != null) {
            authState = state.copyWith(
              event: AuthEvents.signInSuccess,
              loading: false,
            );
          } else {
            authState = state.copyWith(
              event: AuthEvents.signInError,
              loading: false,
            );
          }
        } catch (e) {
          authState = state.copyWith(
            event: AuthEvents.signInError,
            loading: false,
          );
        }

        yield authState;
        break;

      case AuthEvents.logoutStart:
        AuthState authState;
        authState = state.copyWith(
          event: AuthEvents.logoutStart,
          loading: true,
        );

        try {
          await _authService.logOut();
          authState = state.copyWith(
            event: AuthEvents.signInSuccess,
            loading: false,
          );
        } catch (e) {
          authState = state.copyWith(
            event: AuthEvents.signInError,
            loading: false,
          );
        }

        yield authState;
        break;

      default:
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

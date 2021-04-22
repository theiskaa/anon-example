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
    // Listen stream of user  and set state by type of [AuthEvents].
    _userSubscription = _authService.user.listen(
      (user) => add(AuthEvent.authUserChanged(user)),
    );
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    switch (event.type) {
      case AuthEvents.authUserChanged:
        yield* mapEventToAuthUserChanged(event);
        break;
      case AuthEvents.signInStart:
        yield* mapEventToSignInStart(event);
        break;
      case AuthEvents.logoutStart:
        yield* mapEventToLogoutStart(event);
        break;
      default:
    }
  }

  Stream<AuthState> mapEventToAuthUserChanged(dynamic event) async* {
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
    Log.d("User ID: [ ${event.user.id} ]");
    yield authState;
  }

  Stream<AuthState> mapEventToSignInStart(dynamic event) async* {
    AuthState authState;
    authState = state.copyWith(
      event: event.type,
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
  }

  Stream<AuthState> mapEventToLogoutStart(dynamic event) async* {
    AuthState authState;
    authState = state.copyWith(
      event: event.type,
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
  }
}

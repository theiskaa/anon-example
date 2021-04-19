import 'package:anon/core/blocs/auth_bloc.dart';
import 'package:anon/core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AuthEvent authEvent;
  UserModel userModel;

  group('[AuthEvent]', () {
    test('authUserChanged', () {
      authEvent = AuthEvent.authUserChanged(userModel);

      expect(authEvent.type, AuthEvents.authUserChanged);
    });

    test('authenticated', () {
      authEvent = AuthEvent.authenticated(userModel);

      expect(authEvent.type, AuthEvents.authenticated);
    });

    test('unauthenticated', () {
      authEvent = AuthEvent.unauthenticated();

      expect(authEvent.type, AuthEvents.unauthenticated);
    });

    test('signInStart', () {
      authEvent = AuthEvent.signInStart();

      expect(authEvent.type, AuthEvents.signInStart);
    });

    test('signInSuccess', () {
      authEvent = AuthEvent.signInSuccess();

      expect(authEvent.type, AuthEvents.signInSuccess);
    });

    test('signInError', () {
      authEvent = AuthEvent.signInError();

      expect(authEvent.type, AuthEvents.signInError);
    });
    test('logoutStart', () {
      authEvent = AuthEvent.logoutStart();

      expect(authEvent.type, AuthEvents.logoutStart);
    });

    test('logoutSuccess', () {
      authEvent = AuthEvent.logoutSuccess();

      expect(authEvent.type, AuthEvents.logoutSuccess);
    });

    test('logoutError', () {
      authEvent = AuthEvent.logoutError();

      expect(authEvent.type, AuthEvents.logoutError);
    });
  });
}

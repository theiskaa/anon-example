import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/core/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const userModel = UserModel(id: "empty");

  AuthState authState;

  setUpAll(() {
    // Initial version of AuthState.
    authState = AuthState(
      event: AuthEvents.authUserChanged,
      loading: true,
      user: userModel,
    );
  });

  group("[AuthState]", () {
    test("Test if AuthState.copyWith(...) works", () {
      // To test copyWith with default values.
      final defualtAuthState = authState.copyWith();

      // To test copyWith with different values.
      final AuthState newAuthState = authState.copyWith(
        event: AuthEvents.authenticated,
        loading: false,
        user: userModel,
      );

      expect(defualtAuthState.event, authState.event);
      expect(defualtAuthState.loading, authState.loading);
      expect(defualtAuthState.user, authState.user);

      expect(newAuthState.event, AuthEvents.authenticated);
      expect(newAuthState.loading, false);
      expect(newAuthState.user, userModel);
    });

    test("Test if AuthState.unknown()", () {
      AuthState unknownState = AuthState.unknown();

      expect(unknownState.event, null);
      expect(unknownState.loading, true);
      expect(unknownState.user, UserModel.empty);
    });
  });
}

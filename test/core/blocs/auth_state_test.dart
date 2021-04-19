import 'package:anon/core/blocs/auth_bloc.dart';
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
    test("Test if AuthState.copyWith()", () {
      final AuthState newAuthState = authState.copyWith(
        event: AuthEvents.authenticated,
        loading: false,
        user: userModel,
      );

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

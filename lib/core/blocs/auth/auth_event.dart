part of 'auth_bloc.dart';

enum AuthEvents {
  // User managment events.
  authUserChanged,
  authenticated,
  unauthenticated,

  // Authentication events.
  signInStart,
  signInSuccess,
  signInError,
  logoutStart,
  logoutSuccess,
  logoutError,
}

class AuthEvent {
  AuthEvents type;
  UserModel user;

  AuthEvent.authUserChanged(UserModel userModel) {
    this.type = AuthEvents.authUserChanged;
    this.user = userModel;
  }

  AuthEvent.authenticated(UserModel userModel) {
    this.type = AuthEvents.authenticated;
    this.user = userModel;
  }

  AuthEvent.unauthenticated() {
    this.type = AuthEvents.unauthenticated;
  }

  AuthEvent.signInStart() {
    this.type = AuthEvents.signInStart;
  }

  AuthEvent.signInSuccess() {
    this.type = AuthEvents.signInSuccess;
  }

  AuthEvent.signInError() {
    this.type = AuthEvents.signInError;
  }

  AuthEvent.logoutStart() {
    this.type = AuthEvents.logoutStart;
  }

  AuthEvent.logoutSuccess() {
    this.type = AuthEvents.logoutSuccess;
  }

  AuthEvent.logoutError() {
    this.type = AuthEvents.logoutError;
  }
}

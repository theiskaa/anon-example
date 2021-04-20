part of 'auth_bloc.dart';

@immutable
class AuthState {
  final AuthEvents event;
  final bool loading;
  final UserModel user;

  const AuthState({
    @required this.event,
    this.loading,
    this.user,
  });

  AuthState copyWith({
    @required event,
    bool loading,
    UserModel user,
  }) =>
      AuthState(
        event: event ?? this.event,
        loading: loading ?? this.loading,
        user: user ?? this.user,
      );

  const AuthState.unknown()
      : this(
          event: null,
          loading: true,
          user: UserModel.empty,
        );
}

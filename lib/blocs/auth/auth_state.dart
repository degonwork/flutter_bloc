part of 'auth_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  AuthStatus get authstatus => status;
  final auth.User? authUser;
  final User? user;
  final String? name;
  final String? email;
  final String? password;
  const AuthState._({
    this.name = '',
    this.email = '',
    this.password = '',
    this.status = AuthStatus.unknown,
    this.authUser,
    this.user,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({
    required auth.User authUser,
    required User user,
  }) : this._(
          status: AuthStatus.authenticated,
          authUser: authUser,
        );

  const AuthState.unauthenticated(
      {String? name, String? email, String? password})
      : this._(
          name: name,
          email: email,
          password: password,
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [status, authUser, user, name, email, password];
}

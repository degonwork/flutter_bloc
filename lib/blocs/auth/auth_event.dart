part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final auth.User? authUser;
  final User? user;

  const AuthUserChanged({required this.authUser, this.user});
  @override
  List<Object?> get props => [authUser, user];
}

class AuthUserCreate extends AuthEvent {
  final String? name;
  final String? email;
  final String? password;

  const AuthUserCreate({this.name, this.email, this.password});
  @override
  List<Object?> get props => [name, email, password];
}

class AuthSignUp extends AuthEvent {
  final String? name;
  final String email;
  final String password;

  const AuthSignUp({this.name, required this.email, required this.password});
  @override
  List<Object?> get props => [name, email, password];
}

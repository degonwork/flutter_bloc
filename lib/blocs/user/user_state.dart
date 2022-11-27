part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final String name;
  final String email;
  final String password;

  const UserLoaded({this.name = '', this.email = '', this.password = ''});
  @override
  List<Object> get props => [name, email, password];
}

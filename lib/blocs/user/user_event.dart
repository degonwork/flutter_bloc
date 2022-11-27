part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class CreateUser extends UserEvent {
  final String name;
  final String email;
  final String password;

  const CreateUser({this.name = '', this.email = '', this.password = ''});
  @override
  List<Object> get props => [name, email, password];
}

class GetUser extends UserEvent {
  final String? id;
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;

  const GetUser({
    this.id,
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
  });
  @override
  List<Object?> get props =>
      [id, fullName, email, address, city, country, zipCode];
}

class UpdateUser extends UserEvent {
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String country;
  final String zipCode;

  const UpdateUser({
    this.fullName = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.country = '',
    this.zipCode = '',
  });
  @override
  List<Object?> get props => [fullName, email, address, city, country, zipCode];
}

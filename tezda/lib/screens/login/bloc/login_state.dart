import 'package:equatable/equatable.dart';

abstract class LoginBlocState extends Equatable {
  const LoginBlocState();

  @override
  List<Object> get props => [];
}

class LoginInInitial extends LoginBlocState {
  const LoginInInitial();

  @override
  List<Object> get props => [];
}

class EmailState extends LoginBlocState {
  final String email;
  final bool isValidEmail;

  const EmailState({
    required this.email,
    required this.isValidEmail,
  });

  @override
  List<Object> get props => [email, isValidEmail];
}

class PasswordState extends LoginBlocState {
  final String password;
  final bool isValidPassword;

  const PasswordState({
    required this.password,
    required this.isValidPassword,
  });

  @override
  List<Object> get props => [password, isValidPassword];
}

class LoginFailure extends LoginBlocState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class LoginSuccess extends LoginBlocState {
  final String id;
  final String name;
  final String email;
  final String image;
  const LoginSuccess(
      {required this.name,
      required this.id,
      required this.email,
      required this.image});

  @override
  List<Object> get props => [id, name, email, image];
}

class UpdateSuccess extends LoginBlocState {
  const UpdateSuccess();

  @override
  List<Object> get props => [];
}

class LogoutSuccess extends LoginBlocState {
  const LogoutSuccess();

  @override
  List<Object> get props => [];
}

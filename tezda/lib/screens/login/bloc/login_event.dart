import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonTapEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonTapEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutButtonTapEvent extends LoginEvent {
  const LogoutButtonTapEvent();

  @override
  List<Object> get props => [];
}

class SaveButtonTapEvent extends LoginEvent {
  final String email;
  final String name;
  final String img;
  const SaveButtonTapEvent(
      {required this.email, required this.name, required this.img});

  @override
  List<Object> get props => [];
}

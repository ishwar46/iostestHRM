part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginClickEvent extends LoginEvent {
  final String username;
  final String password;
  final String companyCode;

  const LoginClickEvent(
      {required this.username,
      required this.password,
      required this.companyCode});

  @override
  List<Object?> get props => [username, password, companyCode];
}

class LogoutClickEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class AppStarted extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class FingerPrintLogin extends LoginEvent {
  @override
  List<Object?> get props => [];
}

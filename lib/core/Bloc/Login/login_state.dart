part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class Unauthenticated extends LoginState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingstate extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailedState extends LoginState {
  final String message;

  const LoginFailedState(this.message);
  @override
  List<Object?> get props => [message];
}

class LoggedOutState extends LoginState {
  @override
  List<Object?> get props => [];
}

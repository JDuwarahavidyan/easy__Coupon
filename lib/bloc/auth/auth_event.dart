part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String pass;

  AuthEventLogin(this.email, this.pass);
}

class AuthEventLogout extends AuthEvent {}

class AuthEventResetPassword extends AuthEvent {
  final String email;

  AuthEventResetPassword(this.email);
}

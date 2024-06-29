part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}

class AuthStateLogout extends AuthState {}
class AuthStatePasswordReset extends AuthState {}

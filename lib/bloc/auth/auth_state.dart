part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthStateLogout extends AuthState {}

class AuthStateLogin extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final String message;

  AuthStateError(this.message);
}

class AuthStatePasswordReset extends AuthState {}

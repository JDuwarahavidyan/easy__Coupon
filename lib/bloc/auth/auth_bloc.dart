import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        // login
        await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        // Error Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // General Error
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      // logout
      try {
        emit(AuthStateLoading());
        await auth.signOut();
        emit(AuthStateLogout());
      } on FirebaseAuthException catch (e) {
        // Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // General Error
        emit(AuthStateError(e.toString()));
      }
    });

    on<AuthEventResetPassword>((event, emit) async {
      // reset password
      try {
        emit(AuthStateLoading());
        await auth.sendPasswordResetEmail(email: event.email);
        emit(AuthStatePasswordReset());
      } on FirebaseAuthException catch (e) {
        // Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // General Error
        emit(AuthStateError(e.toString()));
      }
    });
  }
}

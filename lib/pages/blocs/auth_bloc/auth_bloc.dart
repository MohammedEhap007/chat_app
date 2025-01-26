
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'user not found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailure(errorMessage: 'wrong password'));
          } else if (e.code == 'network-request-failed') {
            emit(LoginFailure(
                errorMessage: 'connection lost, check your internet'));
          }
        } catch (e) {
          emit(LoginFailure(errorMessage: 'something went wrong'));
        }
      }
    });
  }
}

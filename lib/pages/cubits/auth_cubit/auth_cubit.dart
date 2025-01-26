import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'user not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      } else if (e.code == 'network-request-failed') {
        emit(
            LoginFailure(errorMessage: 'connection lost, check your internet'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'something went wrong'));
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'email already in use'));
      } else if (e.code == 'network-request-failed') {
        emit(RegisterFailure(
            errorMessage: 'connection lost, check your internet'));
      }
    } catch (e) {
      emit(RegisterFailure(
          errorMessage: 'there was an error, please try again'));
    }
  }
}

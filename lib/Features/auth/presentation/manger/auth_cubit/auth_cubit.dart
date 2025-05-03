import 'package:bookly_app/Features/auth/data/models/user_model.dart';
import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(SignUpLoading());
    final result = await authRepo.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(SignUpFailure(message: failure.errMessage!)),
      (userModel) => emit(SignUpSuccess(userModel: userModel)),
    );
  }

  /////////////////////////////////////////
  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await authRepo.logInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginFailure(message: failure.errMessage!)),
      (userModel) => emit(LoginSuccess(userModel: userModel)),
    );
  }
}

import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.authRepo) : super(ProfileInitial());
  final AuthRepo authRepo;
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final userResult = await authRepo.getUserData();
    userResult.fold((failure) => emit(ProfileFailure(failure.errMessage!)),
        (user) => emit(ProfileLoaded(user: user!)));
  }
  ////////////////////////////////////////////////////

  Future<void> updateEmail(
      {String? newEmail, String? password, String? newName}) async {
    emit(ProfileLoading());

    final updateResult = await authRepo.updateProfile(
        newPassword: password, newEmail: newEmail, newName: newName ?? '');
    updateResult.fold(
      (failure) => emit(ProfileFailure(failure.errMessage!)),
      (_) async {
        final userResult = await authRepo.getUserData();
        userResult.fold(
          (failure) => emit(ProfileFailure(failure.errMessage!)),
          (user) => emit(ProfileLoaded(user: user)),
        );
        emit(ProfileSuccess('Profile updated successfully'));
      },
    );
  }

  /////////////////////////////////////////////
  Future<void> signOut() async {
    emit(ProfileLoading());
    final signOutResult = await authRepo.signOut();
    signOutResult.fold(
      (failure) => emit(ProfileFailure(failure.errMessage!)),
      (_) => emit(ProfileSuccess('Signed out successfully')),
    );
  }
}

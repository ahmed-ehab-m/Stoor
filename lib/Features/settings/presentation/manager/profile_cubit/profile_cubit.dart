import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.authRepo) : super(ProfileInitial());
  final AuthRepo authRepo;
  String userName = 'cubit user';
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    final userResult = await authRepo.getUserData();
    userResult.fold((failure) => emit(ProfileFailure(failure.errMessage!)),
        (user) {
      return emit(
        ProfileLoaded(user: user!),
      );
    });
  }
  ////////////////////////////////////////////////////

  Future<void> updateEmail(
      {required String newEmail, required String password}) async {
    emit(ProfileLoading());

    final updateResult =
        await authRepo.updateEmail(newPassword: password, newEmail: newEmail);
    updateResult.fold(
      (failure) => emit(ProfileFailure(failure.errMessage!)),
      (_) async {
        final userResult = await authRepo.getUserData();
        userResult.fold(
          (failure) => emit(ProfileFailure(failure.errMessage!)),
          (user) {
            userName = user!.name;
            return emit(ProfileLoaded(user: user));
          },
        );
      },
    );
  }

////////////////////////////////////////////////
  Future<void> updateName({required String newName}) async {
    emit(ProfileLoading());
    print('newName in cubit: $newName');
    final updateResult = await authRepo.updateName(newName: newName);
    updateResult.fold(
      (failure) => emit(ProfileFailure(failure.errMessage!)),
      (_) async {
        final userResult = await authRepo.getUserData();
        userResult.fold(
          (failure) => emit(ProfileFailure(failure.errMessage!)),
          (user) {
            userName = user!.name;
            print('user.name in cubit: ${user.name}');
            return emit(ProfileLoaded(user: user));
          },
        );
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

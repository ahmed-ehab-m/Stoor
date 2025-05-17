import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/core/data/data_sources/local_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this.localDatasource, this.authRepo) : super(SplashInitial());
  final LocalDatasource localDatasource;
  final AuthRepo authRepo;

  Future<void> checkAppStatus() async {
    emit(SplashLoading());
    try {
      // Check if it's the first time
      final isFirstTime = localDatasource.isFirstTime();
      if (isFirstTime) {
        localDatasource.setFirstTimeDone();
        emit(SplashNavigateToOnboarding());
      } else {
        // Check authentication (implemented in next section)
        final uid = await authRepo.getCurrentUserId();
        if (uid != null) {
          emit(SplashNavigateToHome());
        } else {
          emit(SplashNavigateToSignUp());
        }
      }
    } catch (e) {
      emit(SplashError('Failed to check app status'));
    }
  }
}

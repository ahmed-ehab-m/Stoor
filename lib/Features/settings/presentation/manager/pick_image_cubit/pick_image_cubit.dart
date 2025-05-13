import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/settings/data/repos/settings_repo.dart';
import 'package:equatable/equatable.dart';

part 'pick_image_state.dart';

class PickImageCubit extends Cubit<PickImageState> {
  PickImageCubit(this.settingsRepo) : super(PickImageInitial());
  final SettingsRepo settingsRepo;
  String imagePath = '';
  Future<void> pickProfileImage() async {
    emit(PickImageLoading());
    final result = await settingsRepo.pickProfileImage();
    result.fold((failure) => emit(PickImageFailure(failure.errMessage!)),
        (path) {
      imagePath = path;
      emit(PickImageSuccess(path));
    });
  }

  //////////////////////////////////////////
  Future<void> getProfileImagePath() async {
    emit(PickImageLoading());
    final result = await settingsRepo.getProfileImagePath();
    result.fold((failure) => emit(PickImageFailure(failure.errMessage!)),
        (path) {
      imagePath = path;
      emit(PickImageSuccess(path));
    });
  }
}

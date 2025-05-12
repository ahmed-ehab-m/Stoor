part of 'pick_image_cubit.dart';

sealed class PickImageState extends Equatable {
  const PickImageState();

  @override
  List<Object> get props => [];
}

final class PickImageInitial extends PickImageState {}

final class PickImageLoading extends PickImageState {}

final class PickImageSuccess extends PickImageState {
  final String path;
  const PickImageSuccess(this.path);
}

final class PickImageFailure extends PickImageState {
  final String message;
  const PickImageFailure(this.message);
}

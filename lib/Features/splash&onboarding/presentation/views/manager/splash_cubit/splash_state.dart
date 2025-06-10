part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashNavigateToOnboarding extends SplashState {}

final class SplashNavigateToSignUp extends SplashState {}

final class SplashNavigateToHome extends SplashState {}

final class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
}

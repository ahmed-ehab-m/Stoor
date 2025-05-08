part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpSuccess extends AuthState {
  final UserModel userModel;
  SignUpSuccess({required this.userModel});
}

final class SignUpFailure extends AuthState {
  final String message;

  SignUpFailure({required this.message});
}
/////////////////////////////////

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  final UserModel userModel;
  LoginSuccess({required this.userModel});
}

final class LoginFailure extends AuthState {
  final String message;

  LoginFailure({required this.message});
}

///////////////////////////

final class SignOutLoading extends AuthState {}

final class SignOutSuccess extends AuthState {}

final class SignOutFailure extends AuthState {
  final String message;

  SignOutFailure({required this.message});
}

/////////////////////////////////////
final class TogglePassword extends AuthState {}

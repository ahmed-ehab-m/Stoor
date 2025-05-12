import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepo {
  Future<Either<Failure, String>> pickProfileImage();
  Future<Either<Failure, String>> getProfileImagePath();
  //////////
  Future<void> saveThemeIndex(int index);
  Future<int> getThemeIndex();
  ///////////
  Future<void> saveFontIndex(int index);
  Future<int> getFontIndex();
}

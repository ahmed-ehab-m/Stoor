import 'dart:io';

import 'package:bookly_app/Features/settings/data/repos/settings_repo.dart';
import 'package:bookly_app/core/data/data_sources/local_datasource.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class SettingsRepoImpl implements SettingsRepo {
  final ImagePicker _picker = ImagePicker();
  final LocalDatasource localDatasource;

  SettingsRepoImpl(this.localDatasource);

  @override
  Future<Either<Failure, String>> pickProfileImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return Left(CacheFailure('No image selected'));
    }
    try {
      final cacheResult =
          await localDatasource.saveImage(File(pickedFile.path));
      return cacheResult.fold(
        (failure) => Left(failure),
        (path) => Right(path),
      );
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  ////////////////////////////////////////////
  @override
  Future<Either<Failure, String>> getProfileImagePath() async {
    try {
      final cacheResult = await localDatasource.getProfileImagePath();
      return cacheResult.fold(
        (failure) => Left(failure),
        (path) => Right(path),
      );
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  ///////////////////////////
  @override
  Future<int> getFontIndex() async {
    return await localDatasource.getFontIndex();
  }
  //////////////////////////////

  @override
  Future<int> getThemeIndex() async {
    return await localDatasource.getThemeIndex();
  }

  /////////////////////////////////
  @override
  Future<void> saveFontIndex(int index) async {
    await localDatasource.saveFontIndex(index);
  }

  ///////////////////////////////////
  @override
  Future<void> saveThemeIndex(int index) async {
    await localDatasource.saveThemeIndex(index);
  }
}

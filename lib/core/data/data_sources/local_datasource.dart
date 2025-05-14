import 'dart:io';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/models/user_model.dart';
import 'package:bookly_app/core/utils/constants.dart';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatasource {
  Future<Either<Failure, String>> saveImage(File image);
  Future<Either<Failure, String>> getProfileImagePath();
  /////////////////////
  Future<void> saveInt(String key, int value);
  Future<int> getInt(String key);

  /////////////Theme index/////////////
  Future<void> saveThemeIndex(int value);
  Future<int> getThemeIndex();

  ///////////Font index///////////////
  Future<void> saveFontIndex(int value);
  Future<int> getFontIndex();

  //////////////////////////

  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);

  /////////////////////User data//////////////////////
  Future<Either<Failure, void>> saveUserData(UserModel user);
  Future<Either<Failure, UserModel?>>
      getUserData(); //for reading user data from cache
  Future<Either<Failure, void>> deleteUserData();
}

class LocalDatasourceImpl implements LocalDatasource {
  final SharedPreferences prefs;

  LocalDatasourceImpl(this.prefs);
  int i = 1;

  @override
  Future<Either<Failure, String>> saveImage(File image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${directory.path}/profile_image_$timestamp.jpg';
      final oldImagePath = prefs.getString(kProfileImage);
      if (oldImagePath != null) {
        final oldImageFile = File(oldImagePath);
        if (await oldImageFile.exists()) {
          await oldImageFile.delete();
        }
      }
      await image.copy(path);
      prefs.setString(kProfileImage, path);
      return Right(path);
    } catch (e) {
      return Left(
        CacheFailure(
          e.toString(),
        ),
      );
    }
  }
  ///////////////////////////////////////////

  @override
  Future<Either<Failure, String>> getProfileImagePath() async {
    try {
      final path = prefs.getString(kProfileImage);
      return Right(path ?? '');
    } catch (e) {
      return Left(
        CacheFailure(
          e.toString(),
        ),
      );
    }
  }

////////////////////////////////

  @override
  Future<void> saveInt(String key, int value) async {
    await prefs.setInt(key, value);
  }

  ////////////////////////////////////
  @override
  Future<int> getInt(String key) async {
    return prefs.getInt(key) ?? 0;
  }

//////////////////////////////////////////
  @override
  Future<String?> getString(String key) async {
    return prefs.getString(key) ?? '';
  }

//////////////////////////////////
  @override
  Future<void> saveString(String key, String value) async {
    await prefs.setString(key, value);
  }

/////////////////////////////////
  @override
  Future<Either<Failure, void>> saveUserData(UserModel user) async {
    try {
      await prefs.setString(kUserData, user.toJson());
      return Right(null);
    } catch (e) {
      return Left(CacheFailure.fromCahceError(e.toString()));
    }
  }

  ///////////////////////////////////////
  @override
  Future<Either<Failure, UserModel?>> getUserData() async {
    try {
      final jsonString = prefs.getString(kUserData);
      if (jsonString == null) return Right(null);
      final userModel = UserModel.fromjsonString(jsonString);
      return Right(userModel);
    } on Exception catch (e) {
      return Left(CacheFailure.fromCahceError(e.toString()));
    }
  }

/////////////////////////////////////////////////////
  @override
  Future<Either<Failure, void>> deleteUserData() async {
    try {
      prefs.remove(kUserData);
      return Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure.fromCahceError(e.toString()));
    }
  }

////////////////////////////////////////
  @override
  Future<void> saveThemeIndex(int value) async {
    await prefs.setInt(KThemeyKey, value);
  }

///////////////////////////////////////////////
  @override
  Future<int> getThemeIndex() async {
    int themeIndex = prefs.getInt(KThemeyKey) ?? 3;
    return themeIndex;
  }

/////////////////////////////////////////////////
  @override
  Future<void> saveFontIndex(int value) async {
    await prefs.setInt(KFontKey, value);
  }

//////////////////////////////////////////
  @override
  Future<int> getFontIndex() async {
    int fontIndex = prefs.getInt(KFontKey) ?? 2;
    return fontIndex;
  }
}

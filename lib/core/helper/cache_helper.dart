import 'package:bookly_app/core/models/user_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences prefs;
  CacheHelper(this.prefs);
  Future<Either<Failure, void>> cacheUserData(
      {required UserModel userModel}) async {
    try {
      await prefs.setString(kUserId, userModel.uid!);
      await prefs.setString(kUserName, userModel.name);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
    return const Right(null);
  }

//////////////////////////////////////////////////
  Either<Failure, UserModel> getUserData() {
    try {
      final uid = prefs.getString(kUserId);
      final name = prefs.getString(kUserName);
      if (uid == null || name == null) {
        return Left(CacheFailure('No user data found in cache'));
      }
      return right(UserModel(uid: uid, email: '', name: name ?? ''));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

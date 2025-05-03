import 'package:bookly_app/Features/auth/data/models/user_model.dart';
import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/helper/cache_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth;
  final CacheHelper prefsHelper;
  AuthRepoImpl(this.firebaseAuth, this.prefsHelper);
  @override
  Future<Either<Failure, UserModel>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final cacheResult = prefsHelper.getUserData();
      return cacheResult.fold(
        (failure) => Left(failure),
        (user) async {
          return Right(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

///////////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user =
          UserModel(name: name, email: email, uid: userCredential.user?.uid);
      await prefsHelper.cacheUserData(userModel: user);

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  //////////////////////////

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}

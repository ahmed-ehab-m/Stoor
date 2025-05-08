import 'package:bookly_app/Features/auth/data/models/user_model.dart';
import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/helper/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final CacheHelper prefsHelper;
  AuthRepoImpl(this.firebaseAuth, this.prefsHelper, this.firestore);
  @override
  Future<Either<Failure, UserModel>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      final userDoc = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      await prefsHelper.cacheUserData(
          userModel: UserModel.fromJson(userDoc.data()!));
      final cacheResult = prefsHelper.getUserData();
      return cacheResult.fold(
        (failure) => Left(failure),
        (user) async {
          return Right(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      print('hhhhhhhhhhhhhhhhhhhhhh');
      print(e.code);
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
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
      // await prefsHelper.cacheUserData(userModel: user);
      await firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'name': name, 'email': email, 'uid': userCredential.user?.uid});

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
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
  Future<Either<Failure, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (FirebaseAuth.instance.currentUser == null) {
        return const Right(null);
      } else {
        return Left(ServerFailure('error'));
      }
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

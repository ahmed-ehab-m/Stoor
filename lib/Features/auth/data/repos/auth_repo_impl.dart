import 'package:bookly_app/core/data/data_sources/local_datasource.dart';
import 'package:bookly_app/core/models/user_model.dart';
import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/utils/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final LocalDatasource _localDatasource;
  AuthRepoImpl(this.firebaseAuth, this.firestore, this._localDatasource);
///////////////////////////////////////////////////
  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = UserModel(
        name: name,
        email: email,
        uid: userCredential.user?.uid,
      );
      final cacheResult = await _localDatasource.saveUserData(user);
      return cacheResult.fold(
        (failure) => Left(failure), // نحافظ على الـ CacheFailure الأصلي
        (_) async {
          // تخزين بيانات المستخدم في Firestore
          await firestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .set({
            'name': name,
            'email': email,
            'uid': userCredential.user?.uid,
          });
          return Right(user);
        },
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, UserModel>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      /// get user data from firestore
      final userDoc = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      final userData = userDoc.data()!;
      ////////////
      final user = UserModel.fromMap(userData);
      final cacheResult = await _localDatasource.saveUserData(user);
      return cacheResult.fold(
        (failure) => Left(failure),
        (_) => Right(user),
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

///////////////////////////////////////////////////////////////////////
  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

///////////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final cacheResult = await _localDatasource.deleteUserData();
      return cacheResult.fold((failure) => Left(failure), (_) => Right(null));
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
///////////////////////////////////////////////////////////////////////

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;
      final credintial = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      await firebaseAuth.signInWithCredential(credintial);
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .set({
        'name': googleUser?.displayName,
        'email': googleUser?.email,
        'uid': firebaseAuth.currentUser?.uid
      });
      ////////////////////////////
      final userDoc = await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      final userData = userDoc.data()!;
      final user = UserModel.fromMap(userData);
      final cacheResult = await _localDatasource.saveUserData(user);
      return cacheResult.fold(
        (failure) => Left(failure),
        (_) => Right(user),
      );
      ///////////////////////////
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('error'));
    }
  }

//////////////////////////////////////////////////////////

  @override
  Future<Either<Failure, void>> updateEmail(
      {required String newEmail, required String newPassword}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return Left(ServerFailure(
            'No user is currently signed in. Please sign in again.'));
      }

      try {
        await user.reload();
        final updatedUser = firebaseAuth.currentUser;
        if (updatedUser == null) {
          return Left(ServerFailure('Session expired. Please sign in again.'));
        }
      } catch (e) {
        return Left(ServerFailure('Session expired. Please sign in again.'));
      }

      final userDoc = await firestore.collection('users').doc(user.uid).get();
      final userData = userDoc.data();
      final currentName = userData?['name'] ?? 'User';
      final currentEmail = user.email!;
      final updatedEmail =
          newEmail?.trim().isNotEmpty == true ? newEmail : currentEmail;

      if (updatedEmail != null &&
          updatedEmail.trim().isNotEmpty &&
          newEmail != currentEmail) {
        String? invalidEmail = FormValidation.validateEmail(updatedEmail);
        if (invalidEmail != null) {
          return Left(ServerFailure(invalidEmail));
        }
        if (newPassword == null || newPassword.isEmpty) {
          return Left(ServerFailure('Password Invalid.'));
        }

        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: newPassword,
        );
        try {
          await user.reauthenticateWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          return Left(ServerFailure.fromFirebaseAuthError(e.code));
        }
      }

      await user.updateEmail(newEmail!);
      final updatedUser = UserModel(
        name: currentName,
        email: newEmail,
        uid: user.uid,
      );

      await firestore.collection('users').doc(user.uid).update({
        'email': newEmail,
        // 'name': updatedName,
      });

      final cacheResult = await _localDatasource.saveUserData(updatedUser);
      return cacheResult.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } catch (e) {
      return Left(ServerFailure('Failed to update email: ${e.toString()}'));
    }
  }

///////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, void>> updateName({required String newName}) async {
    try {
      final user = firebaseAuth.currentUser;

      final userDoc = await firestore.collection('users').doc(user!.uid).get();
      final userData = userDoc.data();
      final currentName = userData?['name'] ?? 'User';
      final currentEmail = user.email!;

      final updatedName =
          newName?.trim().isNotEmpty == true ? newName : currentName;
      print('updatedName in auth repo impl: $updatedName');
      final updatedUser = UserModel(
        name: updatedName,
        email: currentEmail,
        uid: user.uid,
      );

      await firestore.collection('users').doc(user.uid).update({
        'name': updatedName,
      });

      final cacheResult = await _localDatasource.saveUserData(updatedUser);
      return cacheResult.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } catch (e) {
      return Left(ServerFailure('Failed to update email: ${e.toString()}'));
    }
  }

///////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, UserModel?>> getUserData() async {
    final result = await _localDatasource.getUserData();
    return result.fold(
      (failure) => Left(failure),
      (user) => Right(user),
    );
  }
}

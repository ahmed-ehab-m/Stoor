import 'package:bookly_app/core/data/data_sources/local_datasource.dart';
import 'package:bookly_app/core/models/user_model.dart';
import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
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
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
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
  // Future<Either<Failure, void>> updateEmail(
  //     {required String newPassword, required String newEmail}) async {
  //   final user = firebaseAuth.currentUser;
  //   print('in update email function');
  //   print(user?.displayName);
  //   print(user?.email);
  //   print(user?.uid);
  //   if (user == null) {
  //     print('user is not signed in. user==null');
  //     return Left(ServerFailure(
  //         'No user is currently signed in. Please sign in again.'));
  //   }
  //   try {
  //     await user.reload(); // تحديث حالة المستخدم
  //   } catch (e) {
  //     return Left(ServerFailure('Session expired. Please sign in again.'));
  //   }
  //   final credential = await EmailAuthProvider.credential(
  //       email: newEmail, password: newPassword);
  //   try {
  //     await user.reauthenticateWithCredential(credential);
  //     await user.updateEmail(newEmail);
  //     ///////////////////////
  //     //get user data from firestore
  //     final userDoc = await firestore.collection('users').doc(user.uid).get();
  //     final userData = userDoc.data();
  //     //////////
  //     final updatedUser = UserModel(
  //       name: userData?['name'] ?? 'User',
  //       email: newEmail,
  //       uid: user.uid,
  //     );
  //     ////update user data in firestore
  //     await firestore
  //         .collection('users')
  //         .doc(user.uid)
  //         .update({'email': newEmail});
  //     final cacheResult = await _localDatasource.saveUserData(updatedUser);
  //     return cacheResult.fold(
  //       (failure) => Left(failure),
  //       (_) => const Right(null),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     return Left(ServerFailure.fromFirebaseAuthError(e.code));
  //   } catch (e) {
  //     throw Exception('Failed to update email: $e');
  //   }
  // }
  @override
  Future<Either<Failure, void>> updateProfile(
      {String? newEmail, String? newPassword, String? newName}) async {
    try {
      final user = firebaseAuth.currentUser;
      print('Current user: ${user?.uid}');
      if (user == null) {
        print('No user signed in');
        return Left(ServerFailure(
            'No user is currently signed in. Please sign in again.'));
      }

      // تحديث حالة المستخدم للتحقق من صلاحية الجلسة
      try {
        print('Reloading user...');
        await user.reload();
        // تحديث user بعد reload
        final updatedUser = firebaseAuth.currentUser;
        if (updatedUser == null) {
          print('User became null after reload');
          return Left(ServerFailure('Session expired. Please sign in again.'));
        }
      } catch (e) {
        print('Reload failed: $e');
        return Left(ServerFailure('Session expired. Please sign in again.'));
      }

      print('Creating credential for email: ${user.email}, password: [HIDDEN]');
      final userDoc = await firestore.collection('users').doc(user.uid).get();
      final userData = userDoc.data();
      final currentName = userData?['name'] ?? 'User';
      final currentEmail = user.email!;
      final updatedEmail =
          newEmail?.trim().isNotEmpty == true ? newEmail : currentEmail;
      final updatedName =
          newName?.trim().isNotEmpty == true ? newName : currentName;
      if (newEmail != null &&
          newEmail.trim().isNotEmpty &&
          newEmail != currentEmail) {
        if (newPassword == null || newPassword.isEmpty) {
          print('Password required for email update');
          return Left(ServerFailure('Password is required to update email.'));
        }

        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: newPassword!,
        );

        // محاولة إعادة المصادقة
        try {
          print('Reauthenticating...');
          await user.reauthenticateWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          print('Reauthentication failed: ${e.code} - ${e.message}');
          if (e.code == 'wrong-password') {
            return Left(ServerFailure('Incorrect password. Please try again.'));
          } else if (e.code == 'user-not-found') {
            return Left(ServerFailure('User not found. Please sign in again.'));
          } else {
            return Left(
                ServerFailure('Failed to reauthenticate: ${e.message}'));
          }
        }
      }

      print('Updating email to: $newEmail');
      await user.updateEmail(newEmail!);

      print('Updating Firestore user data...');

      final updatedUser = UserModel(
        name: updatedName,
        email: newEmail,
        uid: user.uid,
      );

      await firestore.collection('users').doc(user.uid).update({
        'email': newEmail,
        'name': updatedName,
      });

      print('Saving user data to local cache...');
      final cacheResult = await _localDatasource.saveUserData(updatedUser);
      return cacheResult.fold(
        (failure) => Left(failure),
        (_) => Right(null),
      );
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      return Left(ServerFailure.fromFirebaseAuthError(e.code));
    } catch (e) {
      print('General error: $e');
      return Left(ServerFailure('Failed to update email: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getUserData() async {
    final result = await _localDatasource.getUserData();
    return result.fold(
      (failure) => Left(failure),
      (user) => Right(user),
    );
  }
}

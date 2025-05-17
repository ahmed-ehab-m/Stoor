import 'package:bookly_app/core/models/user_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> loginWithGoogle();
  Future<Either<Failure, void>> updateEmail(
      {required String newPassword, required String newEmail});

  Future<Either<Failure, void>> updateName({required String newName});

  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel?>> getUserData();
  Future<String?> getCurrentUserId();
}

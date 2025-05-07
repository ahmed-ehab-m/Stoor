import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class GeminiRepo {
  Future<Either<Failure, List<BookModel?>>> getRecommendedBook(
      {required String userDescription, required List<BookModel> books});
}

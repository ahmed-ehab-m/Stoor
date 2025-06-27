import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  ///////////////////////FETCH Books/////////////////////////////
  Future<Either<Failure, List<BookModel>>> fetchAllBooks();
  Future<Either<Failure, List<BookModel>>> fetchHighestRatedBooks();
  Future<Either<Failure, List<BookModel>>> fetchLowestRatedBooks();
  Future<Either<Failure, List<BookModel>>> fetchBookMark({required String uid});
  /////////////////// ADD and DELETE TO BOOKMARK//////////////////////////////
  Future<Either<Failure, void>> addToBookMark(
      {required String uid, required int bookId});

  Future<Either<Failure, void>> deleteBookMark(
      {required int bookId, required String uid});
}

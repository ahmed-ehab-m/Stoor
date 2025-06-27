import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
  ///////////////////FETCH Functions//////////////////////

  @override
  Future<Either<Failure, List<BookModel>>> fetchAllBooks() async {
    try {
      var data = await apiService.get(endpoint: 'books');
      List<BookModel> books = [];
      for (var item in data['data']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  /////////////////////////////////////////
  @override
  Future<Either<Failure, List<BookModel>>> fetchLowestRatedBooks() async {
    try {
      var data = await apiService.get(endpoint: 'books/lowest-rated');
      List<BookModel> books = [];
      for (var item in data['data']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  /////////////////////////////////////////////
  @override
  Future<Either<Failure, List<BookModel>>> fetchHighestRatedBooks() async {
    try {
      var data = await apiService.get(endpoint: 'books/highest-rated');
      List<BookModel> books = [];
      for (var item in data['data']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  ////////////////////////////////////

  @override
  Future<Either<Failure, List<BookModel>>> fetchBookMark(
      {required String uid}) async {
    try {
      var data = await apiService.get(endpoint: 'favorites?user_id=$uid');
      List<BookModel> books = [];
      for (var item in data['data']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  //////////////Book Mark Functions//////////////////////
  @override
  Future<Either<Failure, void>> addToBookMark(
      {required String uid, required int bookId}) async {
    try {
      await apiService.post(bookId: bookId, userId: uid);
      return right(null);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  /////////////////////////////////////////////
  @override
  Future<Either<Failure, void>> deleteBookMark(
      {required int bookId, required String uid}) async {
    try {
      await apiService.delete(bookId: bookId, userId: uid);
      return right(null);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);
  /////////////////////////////////////////
  @override
  Future<Either<Failure, List<Apibook>>> fetchBookMark(
      {required String uid}) async {
    try {
      var data = await apiService.apiGet(endpoint: 'favorites?user_id=$uid');
      List<Apibook> books = [];
      for (var item in data['data']) {
        books.add(Apibook.fromJson(item));
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
  Future<Either<Failure, void>> addToBookMark(
      {required String uid, required String bookId}) async {
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

  ////////////////////////////////////
  @override
  Future<Either<Failure, List<Apibook>>> fetchAllBooks() async {
    try {
      var data = await apiService.apiGet(endpoint: 'books');
      List<Apibook> books = [];
      for (var item in data['data']) {
        books.add(Apibook.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      //dio error happen if status code is not 200
      // dio error holds status code and response data
      // dio error => server failure
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  //////////////////////////////////
  @override
  Future<Either<Failure, List<BookModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(
          endpoint:
              'volumes?Filtering=free-ebooks&Sorting=newest&q=subject:Programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } on Exception catch (e) {
      //dio error happen if status code is not 200
      // dio error holds status code and response data
      // dio error => server failure
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  ////////////////////////////Test New Api//////////////////////////////////

  // void fetchBooks() async {
  //   Dio dio = Dio();
  //   var cookieJar = CookieJar();
  //   dio.interceptors.add(CookieManager(cookieJar));

  //   try {
  //     Response response = await dio.get(
  //       'https://hadeer.wuaze.com/api/v1/books/highest-rated',
  //       queryParameters: {'i': 1},
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //           'User-Agent':
  //               'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
  //           'Accept-Language': 'en-US,en;q=0.9',
  //         },
  //         followRedirects: true,
  //         maxRedirects: 5,
  //       ),
  //     );
  //     print(response.data);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  //////////////////////////////////////////////////////////////

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
          endpoint: 'volumes?Filtering=free-ebooks&q=subject:Programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          books.add(BookModel.fromJson(item));
        } on Exception {
          return left(ServerFailure('error'));
        }
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
      {required String category}) async {
    try {
      var data = await apiService.get(
          endpoint:
              'volumes?Filtering=free-ebooks&Sorting=relevance&q=subject:Programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        try {
          books.add(BookModel.fromJson(item));
        } on Exception {
          return left(ServerFailure('error'));
        }
      }
      return right(books);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

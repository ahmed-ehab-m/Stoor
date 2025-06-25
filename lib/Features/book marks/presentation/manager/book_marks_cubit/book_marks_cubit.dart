import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_marks_state.dart';

class BookMarksBooksCubit extends Cubit<BookMarksState> {
  BookMarksBooksCubit(this.homeRepo, this.authRepo) : super(BookMarksInitial());
  final HomeRepo homeRepo;
  final AuthRepo authRepo;
  List<BookModel> books = [];
  /////////////////////////////////
  Future<void> deleteBookMark(
      {required String uid, required String bookId}) async {
    emit(DeleteBookMarksLoading(
      bookId,
    ));
    var result = await homeRepo.deleteBookMark(bookId: bookId, uid: uid);
    result.fold(
      (failure) => emit(DeleteBookMarksFailure(failure.errMessage!)),
      (_) async {
        final fetchResult = await homeRepo.fetchBookMark(uid: uid ?? '');
        fetchResult.fold(
          (failure) => emit(FetchBookMarksFailure(failure.errMessage!)),
          (fetchedBooks) {
            books = fetchedBooks;
            emit(DeleteBookMarksSuccess());
          },
        );
      },
    );
  }

  //////////////////////////////////////
  Future<void> addtoBookMarks(
      {required String uid, required String bookId}) async {
    emit(AddBookMarksLoading(
      bookId,
    ));
    var result = await homeRepo.addToBookMark(
      uid: uid,
      bookId: bookId,
    );
    result.fold(
      (failure) => emit(AddBookMarksFailure(failure.errMessage!)),
      (_) async {
        final fetchResult = await homeRepo.fetchBookMark(uid: uid ?? '');
        fetchResult.fold(
          (failure) => emit(FetchBookMarksFailure(failure.errMessage!)),
          (fetchedBooks) {
            books = fetchedBooks;
            emit(const AddBookMarksSuccess());
          },
        );
      },
    );
  }
  ////////////////////////////////////////

  Future<void> fetchBookMark() async {
    emit(FetchBookMarksLoading());
    final uid = await authRepo.getCurrentUserId();

    var result = await homeRepo.fetchBookMark(uid: uid ?? '');
    result.fold(
      (failure) => emit(FetchBookMarksFailure(failure.errMessage!)),
      (books) {
        this.books = books;
        emit(FetchBookMarksSuccess(books));
      },
    );
  }
}

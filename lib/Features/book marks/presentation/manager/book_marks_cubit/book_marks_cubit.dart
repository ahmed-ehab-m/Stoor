import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_marks_state.dart';

class BookMarksCubit extends Cubit<BookMarksState> {
  BookMarksCubit(this.homeRepo, this.authRepo) : super(BookMarksInitial());
  final HomeRepo homeRepo;
  final AuthRepo authRepo;
  List<BookModel> books = [];
  bool isBookmarked = false;
  List<int?> bookMarksIds = [];
  int? currentLoadingBookId;
  /////////////////////////////////
  Future<void> deleteBookMark(
      {required String uid, required int bookId}) async {
    currentLoadingBookId = bookId;

    emit(DeleteBookMarksLoading(bookId));
    var result = await homeRepo.deleteBookMark(bookId: bookId, uid: uid);
    result.fold(
      (failure) {
        currentLoadingBookId = null;
        emit(DeleteBookMarksFailure(failure.errMessage!));
      },
      (_) async {
        bookMarksIds.removeWhere((id) => id == bookId);
        books.removeWhere((book) => book.id == bookId);

        currentLoadingBookId = null;
        final fetchResult = await homeRepo.fetchBookMark(uid: uid);
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
      {required String uid, required int bookId}) async {
    currentLoadingBookId = bookId;
    emit(AddBookMarksLoading(bookId));
    var result = await homeRepo.addToBookMark(
      uid: uid,
      bookId: bookId,
    );
    result.fold(
      (failure) {
        currentLoadingBookId = null;
        emit(AddBookMarksFailure(failure.errMessage!));
      },
      (_) async {
        if (!bookMarksIds.contains(bookId)) {
          bookMarksIds.add(bookId);
        }
        currentLoadingBookId = null;
        // emit(const AddBookMarksSuccess());
        final fetchResult = await homeRepo.fetchBookMark(uid: uid);
        fetchResult.fold(
          (failure) => emit(FetchBookMarksFailure(failure.errMessage!)),
          (fetchedBooks) {
            books = fetchedBooks;
            // bookMarksIds.add(bookId);
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
      (failure) => {
        currentLoadingBookId = null,
        emit(AddBookMarksFailure(failure.errMessage!)),
      },
      (fetchedBooks) {
        books = fetchedBooks;
        // مسح القائمة القديمة وإعادة ملؤها
        bookMarksIds.clear();
        for (var book in fetchedBooks) {
          if (book.id != null) {
            bookMarksIds.add(book.id!);
          }
        }
        emit(FetchBookMarksSuccess(fetchedBooks));
      },
    );
  }

  bool isBookBookmarked(int bookId) {
    return bookMarksIds.contains(bookId);
  }

  bool isBookLoading(int bookId) {
    return currentLoadingBookId == bookId &&
        (state is AddBookMarksLoading || state is DeleteBookMarksLoading);
  }
}

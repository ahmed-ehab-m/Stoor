import 'package:bookly_app/Features/auth/data/repos/auth_repo.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_marks_books_state.dart';

class BookMarksBooksCubit extends Cubit<BookMarksBooksState> {
  BookMarksBooksCubit(this.homeRepo, this.authRepo)
      : super(BookMarksBooksInitial());
  final HomeRepo homeRepo;
  final AuthRepo authRepo;

  Future<void> addtoBookMarks(
      {required String uid, required String bookId}) async {
    emit(AddBookMarksBooksLoading());
    var result = await homeRepo.addToBookMark(
      uid: uid,
      bookId: bookId,
    );
    result.fold(
      (failure) => emit(AddBookMarksBooksFailure(failure.errMessage!)),
      (_) {
        emit(const AddBookMarksBooksSuccess());
      },
    );
  }
  ////////////////////////////////////////

  Future<void> fetchBookMark() async {
    emit(FetchBookMarksBooksLoading());
    final uid = await authRepo.getCurrentUserId();

    var result = await homeRepo.fetchBookMark(uid: uid ?? '');
    result.fold(
      (failure) => emit(FetchBookMarksBooksFailure(failure.errMessage!)),
      (books) {
        emit(FetchBookMarksBooksSuccess(books));
      },
    );
  }
}

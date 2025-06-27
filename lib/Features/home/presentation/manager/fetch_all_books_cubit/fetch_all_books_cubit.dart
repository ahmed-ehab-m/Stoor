import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_all_books_state.dart';

class FetchAllBooksCubit extends Cubit<FetchAllBooksState> {
  FetchAllBooksCubit(this.homeRepo) : super(FetchAllBooksInitial());
  final HomeRepo homeRepo;
  final List<BookModel> allBooks = [];

  ////////////////
  Future<void> fetchAllBooks() async {
    emit(FetchAllBooksLoading());
    var result = await homeRepo.fetchAllBooks();
    result.fold(
      (failure) => emit(FetchAllBooksFailure(failure.errMessage!)),
      (books) {
        emit(FetchAllBooksSuccess(books));
        allBooks.addAll(books);
      },
    );
  }
}

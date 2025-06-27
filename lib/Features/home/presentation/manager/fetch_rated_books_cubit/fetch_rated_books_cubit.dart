import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_rated_books_state.dart';

class FetchRatedBooksCubit extends Cubit<FetchRatedBooksState> {
  FetchRatedBooksCubit(this.homeRepo) : super(FetchRatedBooksInitial());
  final HomeRepo homeRepo;
  String booksTitle = 'Highest Rated ';
  bool isHighestRated = true;
  Future<void> fetcHighestRatedBooks() async {
    booksTitle = 'Highest Rated ';
    isHighestRated = true;
    emit(FetchHighestRatedBooksLoading());
    var result = await homeRepo.fetchHighestRatedBooks();
    result.fold(
      (failure) => emit(FetchHighestRatedBooksFailure(failure.errMessage!)),
      (books) {
        emit(FetchHighestRatedBooksSuccess(books));
        // AllBooks.addAll(books);
      },
    );
  }

  /////////////////////////////
  Future<void> fetchLowestRatedBooks() async {
    isHighestRated = false;

    booksTitle = 'Lowest Rated ';
    emit(FetchLowestRatedBooksLoading());
    var result = await homeRepo.fetchLowestRatedBooks();
    result.fold(
      (failure) => emit(FetchLowestRatedBooksFailure(failure.errMessage!)),
      (books) {
        emit(FetchLowestRatedBooksSuccess(books));
        // AllBooks.addAll(books);
      },
    );
  }
}

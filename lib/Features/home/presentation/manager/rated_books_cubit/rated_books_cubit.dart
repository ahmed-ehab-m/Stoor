import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';

part 'rated_books_state.dart';

class RatedBooksCubit extends Cubit<RatedBooksState> {
  RatedBooksCubit(this.homeRepo) : super(RatedBooksInitial());
  final HomeRepo homeRepo;
  String booksTitle = 'Highest Rated ';
  bool isHighestRated = true;
  Future<void> fetcHighestRatedBooks() async {
    booksTitle = 'Highest Rated ';
    isHighestRated = true;
    emit(HighestRatedBooksLoading());
    var result = await homeRepo.fetchHighestRatedBooks();
    result.fold(
      (failure) => emit(HighestRatedBooksFailure(failure.errMessage!)),
      (books) {
        emit(HighestRatedBooksSuccess(books));
        // AllBooks.addAll(books);
      },
    );
  }

  /////////////////////////////
  Future<void> fetchLowestRatedBooks() async {
    isHighestRated = false;

    booksTitle = 'Lowest Rated ';
    emit(LowestRatedBooksLoading());
    var result = await homeRepo.fetchLowestRatedBooks();
    result.fold(
      (failure) => emit(LowestRatedBooksFailure(failure.errMessage!)),
      (books) {
        emit(LowestRatedBooksSuccess(books));
        // AllBooks.addAll(books);
      },
    );
  }
}

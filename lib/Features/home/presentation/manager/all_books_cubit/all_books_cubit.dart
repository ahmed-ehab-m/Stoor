import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'all_books_state.dart';

class AllBooksCubit extends Cubit<AllBooksState> {
  AllBooksCubit(this.homeRepo) : super(AllBooksInitial());
  final HomeRepo homeRepo;
  final List<BookModel> allBooks = [];

  ////////////////
  Future<void> fetchAllBooks() async {
    emit(AllBooksLoading());
    var result = await homeRepo.fetchAllBooks();
    result.fold(
      (failure) => emit(AllBooksFailure(failure.errMessage!)),
      (books) {
        emit(AllBooksSuccess(books));
        allBooks.addAll(books);
      },
    );
  }
}

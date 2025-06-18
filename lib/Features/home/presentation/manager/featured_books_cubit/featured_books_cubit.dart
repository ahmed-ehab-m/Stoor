import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.homeRepo) : super(FeaturedBooksInitial());
  final HomeRepo homeRepo;
  final List<BookModel> featuredBooks = [];
  final List<Apibook> AllBooks = [];

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold(
      (failure) => emit(FeaturedBooksFailure(failure.errMessage!)),
      (books) {
        emit(FeaturedBooksSuccess(books));
        featuredBooks.addAll(books);
      },
    );
  }

  //////////////////
  Future<void> fetchAllBooks() async {
    emit(AllBooksLoading());
    var result = await homeRepo.fetchAllBooks();
    result.fold(
      (failure) => emit(AllBooksFailure(failure.errMessage!)),
      (books) {
        emit(AllBooksSuccess(books));
        AllBooks.addAll(books);
      },
    );
  }
}

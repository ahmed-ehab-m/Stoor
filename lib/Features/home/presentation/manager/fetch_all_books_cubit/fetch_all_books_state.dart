part of 'fetch_all_books_cubit.dart';

sealed class FetchAllBooksState extends Equatable {
  const FetchAllBooksState();

  @override
  List<Object> get props => [];
}

final class FetchAllBooksInitial extends FetchAllBooksState {}

///////////////////////////////////////////

final class FetchAllBooksLoading extends FetchAllBooksState {}

final class FetchAllBooksSuccess extends FetchAllBooksState {
  final List<BookModel> books;
  const FetchAllBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class FetchAllBooksFailure extends FetchAllBooksState {
  final String errorMessage;
  const FetchAllBooksFailure(this.errorMessage);
}

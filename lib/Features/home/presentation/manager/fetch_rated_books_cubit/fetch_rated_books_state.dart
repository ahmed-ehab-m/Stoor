part of 'fetch_rated_books_cubit.dart';

sealed class FetchRatedBooksState extends Equatable {
  const FetchRatedBooksState();

  @override
  List<Object> get props => [];
}

final class FetchRatedBooksInitial extends FetchRatedBooksState {}

final class FetchHighestRatedBooksLoading extends FetchRatedBooksState {}

final class FetchHighestRatedBooksSuccess extends FetchRatedBooksState {
  final List<BookModel> books;

  const FetchHighestRatedBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class FetchHighestRatedBooksFailure extends FetchRatedBooksState {
  final String errorMessage;

  const FetchHighestRatedBooksFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

///////////////Lowest Rated Books////////////////////
final class FetchLowestRatedBooksLoading extends FetchRatedBooksState {}

final class FetchLowestRatedBooksSuccess extends FetchRatedBooksState {
  final List<BookModel> books;

  const FetchLowestRatedBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class FetchLowestRatedBooksFailure extends FetchRatedBooksState {
  final String errorMessage;

  const FetchLowestRatedBooksFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

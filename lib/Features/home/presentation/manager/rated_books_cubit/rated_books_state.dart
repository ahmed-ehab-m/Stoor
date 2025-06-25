part of 'rated_books_cubit.dart';

sealed class RatedBooksState extends Equatable {
  const RatedBooksState();

  @override
  List<Object> get props => [];
}

final class RatedBooksInitial extends RatedBooksState {}

final class HighestRatedBooksLoading extends RatedBooksState {}

final class HighestRatedBooksSuccess extends RatedBooksState {
  final List<BookModel> books;

  const HighestRatedBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class HighestRatedBooksFailure extends RatedBooksState {
  final String errorMessage;

  const HighestRatedBooksFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

///////////////Lowest Rated Books////////////////////
final class LowestRatedBooksLoading extends RatedBooksState {}

final class LowestRatedBooksSuccess extends RatedBooksState {
  final List<BookModel> books;

  const LowestRatedBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class LowestRatedBooksFailure extends RatedBooksState {
  final String errorMessage;

  const LowestRatedBooksFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

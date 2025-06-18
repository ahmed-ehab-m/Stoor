part of 'featured_books_cubit.dart';

sealed class FeaturedBooksState extends Equatable {
  const FeaturedBooksState();

  @override
  List<Object> get props => [];
}
///////////////////////////////////////////

final class AllBooksLoading extends FeaturedBooksState {}

final class AllBooksSuccess extends FeaturedBooksState {
  final List<Apibook> books;
  const AllBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class AllBooksFailure extends FeaturedBooksState {
  final String errorMessage;
  const AllBooksFailure(this.errorMessage);
}

//////////////////////////////////////
final class FeaturedBooksInitial extends FeaturedBooksState {}

final class FeaturedBooksLoading extends FeaturedBooksState {}

final class FeaturedBooksSuccess extends FeaturedBooksState {
  final List<BookModel> books;
  const FeaturedBooksSuccess(this.books);

  @override
  List<Object> get props => [books];
}

final class FeaturedBooksFailure extends FeaturedBooksState {
  final String errorMessage;
  const FeaturedBooksFailure(this.errorMessage);
}

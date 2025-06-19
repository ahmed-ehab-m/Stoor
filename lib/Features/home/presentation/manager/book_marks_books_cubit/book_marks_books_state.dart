part of 'book_marks_books_cubit.dart';

sealed class BookMarksBooksState extends Equatable {
  const BookMarksBooksState();

  @override
  List<Object> get props => [];
}

final class BookMarksBooksInitial extends BookMarksBooksState {}

///////////////////////DeleteBookMarksBooks/////////////////////////////////
final class DeleteBookMarksBooksLoading extends BookMarksBooksState {}

final class DeleteBookMarksBooksSuccess extends BookMarksBooksState {}

final class DeleteBookMarksBooksFailure extends BookMarksBooksState {
  final String errMessage;
  const DeleteBookMarksBooksFailure(this.errMessage);
}

///////////////////////AddBookMarksBooks/////////////////////////////////
final class AddBookMarksBooksLoading extends BookMarksBooksState {}

final class AddBookMarksBooksSuccess extends BookMarksBooksState {
  const AddBookMarksBooksSuccess();
}

final class AddBookMarksBooksFailure extends BookMarksBooksState {
  final String errMessage;
  const AddBookMarksBooksFailure(this.errMessage);
}

///////////////////////FetchBookMarksBooks/////////////////////////////////
final class FetchBookMarksBooksLoading extends BookMarksBooksState {}

final class FetchBookMarksBooksSuccess extends BookMarksBooksState {
  final List<Apibook> books;
  const FetchBookMarksBooksSuccess(this.books);
}

final class FetchBookMarksBooksFailure extends BookMarksBooksState {
  final String errMessage;
  const FetchBookMarksBooksFailure(this.errMessage);
}

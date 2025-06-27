part of 'book_marks_cubit.dart';

sealed class BookMarksState extends Equatable {
  const BookMarksState();

  @override
  List<Object> get props => [];
}

final class BookMarksInitial extends BookMarksState {}

///////////////////////DeleteBookMarksBooks/////////////////////////////////
final class DeleteBookMarksLoading extends BookMarksState {
  final int bookId;
  const DeleteBookMarksLoading(this.bookId);
}

final class DeleteBookMarksSuccess extends BookMarksState {}

final class DeleteBookMarksFailure extends BookMarksState {
  final String errMessage;
  const DeleteBookMarksFailure(this.errMessage);
}

///////////////////////AddBookMarksBooks/////////////////////////////////
final class AddBookMarksLoading extends BookMarksState {
  final int bookId;
  const AddBookMarksLoading(this.bookId);
}

final class AddBookMarksSuccess extends BookMarksState {
  const AddBookMarksSuccess();
}

final class AddBookMarksFailure extends BookMarksState {
  final String errMessage;
  const AddBookMarksFailure(this.errMessage);
}

///////////////////////FetchBookMarksBooks/////////////////////////////////
final class FetchBookMarksLoading extends BookMarksState {}

final class FetchBookMarksSuccess extends BookMarksState {
  final List<BookModel> books;
  const FetchBookMarksSuccess(this.books);
}

final class FetchBookMarksFailure extends BookMarksState {
  final String errMessage;
  const FetchBookMarksFailure(this.errMessage);
}

part of 'lowest_rated_cubit.dart';

sealed class LowestRatedState extends Equatable {
  const LowestRatedState();

  @override
  List<Object> get props => [];
}

final class LowestRatedInitial extends LowestRatedState {}

final class LowestRatedLoading extends LowestRatedState {}

final class LowestRatedSuccess extends LowestRatedState {
  final List<Apibook> books;
  const LowestRatedSuccess(this.books);
}

final class LowestRatedFailure extends LowestRatedState {
  final String errMessage;
  const LowestRatedFailure(this.errMessage);
}

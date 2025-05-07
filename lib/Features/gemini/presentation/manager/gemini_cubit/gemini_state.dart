part of 'gemini_cubit.dart';

sealed class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminiInitial extends GeminiState {}

final class GeminiLoadingState extends GeminiState {}

final class GeminiLoadedState extends GeminiState {
  final List<BookModel?> recommendedBook;
  const GeminiLoadedState(this.recommendedBook);
  @override
  List<Object> get props => [recommendedBook];
}

final class GeminiErrorState extends GeminiState {
  final String errorMessage;
  const GeminiErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

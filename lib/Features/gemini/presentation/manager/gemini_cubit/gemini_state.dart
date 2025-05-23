part of 'gemini_cubit.dart';

sealed class GeminiState extends Equatable {
  const GeminiState();

  @override
  List<Object> get props => [];
}

final class GeminiInitial extends GeminiState {}

final class GeminiLoadingState extends GeminiState {
  final List<ChatMessageModel> chatHistory;

  const GeminiLoadingState({required this.chatHistory});
}

final class GeminiLoadedState extends GeminiState {
  final List<BookModel?> recommendedBook;
  final List<ChatMessageModel> chatHistory;

  const GeminiLoadedState(this.recommendedBook, this.chatHistory);
  @override
  List<Object> get props => [recommendedBook];
}

final class GeminiErrorState extends GeminiState {
  final String errorMessage;
  final List<ChatMessageModel> chatHistory;

  const GeminiErrorState(
      {required this.errorMessage, required this.chatHistory});
  @override
  List<Object> get props => [errorMessage];
}

/////////////////////////save and get chat history/////////////////////////
final class GeminiChatHistoryLoadedState extends GeminiState {
  final List<ChatMessageModel> chatHistory;

  const GeminiChatHistoryLoadedState(this.chatHistory);
  @override
  List<Object> get props => [chatHistory];
}

final class GeminiChatHistoryLoadingState extends GeminiState {
  const GeminiChatHistoryLoadingState();
}

final class GeminiChatHistoryFailureState extends GeminiState {
  final String errorMessage;

  const GeminiChatHistoryFailureState(this.errorMessage);
}

///////////////////////////Save Message/////////////////////////////
final class GeminiMessageSavedState extends GeminiState {
  const GeminiMessageSavedState();
}

final class GeminiMessageSaveFailureState extends GeminiState {
  final String errorMessage;

  const GeminiMessageSaveFailureState({required this.errorMessage});
}

final class GeminiMessageLoadingState extends GeminiState {
  const GeminiMessageLoadingState();
}

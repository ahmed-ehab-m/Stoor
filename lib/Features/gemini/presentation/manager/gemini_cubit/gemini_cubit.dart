import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gemini_state.dart';

class GeminiCubit extends Cubit<GeminiState> {
  GeminiCubit(
    this._geminiRepo,
  ) : super(GeminiInitial());
  final GeminiRepo _geminiRepo;
  // String? question;
  final List<ChatMessageModel> chatHistory = [];

/////////////////////////////////////////////////
  Future<void> addMessage(
      {required String type, required dynamic message, String? status}) async {
    final chatMessage =
        ChatMessageModel(type: type, message: message, status: status);
    chatHistory.add(chatMessage);
    var saveResult = await _geminiRepo.saveChatHistory(chatHistory);
    saveResult.fold((failure) {
      emit(
        GeminiChatHistoryFailureState(failure.errMessage!),
      );
    }, (_) {});
  }

/////////////////////////////////////////////////
  Future<void> getChatHistory() async {
    emit(GeminiChatHistoryLoadingState());
    var result = await _geminiRepo.getChatHistory();

    result.fold((failure) {
      emit(
        GeminiChatHistoryFailureState(failure.errMessage!),
      );
    }, (chatHistory) {
      chatHistory = chatHistory;
      emit(
        GeminiChatHistoryLoadedState(
          chatHistory,
        ),
      );
    });
  }

////////////////////////////////////////////////////
  int findLoadingBotIndex() {
    for (var i = 0; i < chatHistory.length; i++) {
      if (chatHistory[i].type == 'bot' && chatHistory[i].status == 'loading') {
        return i;
      }
    }
    return -1;
  }

/////////////////////////////////////////////
  Future<void> getRecommendedBook({
    required String userDescription,
    required List<BookModel> books,
  }) async {
    addMessage(type: 'user', message: userDescription);
    addMessage(type: 'bot', message: 'Loading...', status: 'loading');

    emit(GeminiLoadingState(
      chatHistory: chatHistory,
    ));
    // question = userDescription;
    var result = await _geminiRepo.getRecommendedBook(
      userDescription: userDescription,
      books: books,
    );
    result.fold((failure) {
      // chatHistory[0] = {'type': 'bot', 'message': 'error', 'status': 'error'};
      emit(
        GeminiErrorState(
          errorMessage: failure.errMessage!,
          chatHistory: chatHistory,
        ),
      );
    }, (bookModel) {
      final index = findLoadingBotIndex();
      print('index in cubit last');
      print(index);
      if (index != -1) {
        chatHistory[index] = ChatMessageModel(
          type: 'bot',
          message: bookModel,
          status: 'done',
        );
      }

      emit(
        GeminiLoadedState(bookModel, chatHistory),
      );
    });
  }
}

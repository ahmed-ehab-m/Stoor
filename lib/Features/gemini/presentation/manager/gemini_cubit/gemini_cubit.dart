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
  List<ChatMessageModel> chatHistory = [];
/////////////////////////////////////////////////
  void addMessage({required String type, dynamic message, String? status}) {
    final chatMessage =
        ChatMessageModel(type: type, message: message, status: status);
    chatHistory.insert(0, chatMessage);
    print('added message type  $type , message $message , status $status');
    print('Current chatHistory length: ${chatHistory.length}');
  }

//////////////////////////////////////////////////
  ///
  Future<void> saveChatHistory(
      {required List<ChatMessageModel> chatHistory}) async {
    emit(GeminiMessageLoadingState());
    var result = await _geminiRepo.saveChatHistory(chatHistory);
    result.fold((failure) {
      print('Save chat history failed: ${failure.errMessage}');
      emit(
        GeminiMessageSaveFailureState(
          errorMessage: failure.errMessage!,
        ),
      );
    }, (success) {
      print('Chat history saved successfully');
      emit(GeminiMessageSavedState());
    });
  }

/////////////////////////////////////////////////
  Future<void> getChatHistory() async {
    emit(GeminiChatHistoryLoadingState());
    var result = await _geminiRepo.getChatHistory();

    result.fold((failure) {
      print('Get chat history failed: ${failure.errMessage}');

      emit(
        GeminiChatHistoryFailureState(failure.errMessage!),
      );
    }, (chathistory) {
      chatHistory = chathistory;
      print('Get chat history success: ${chatHistory.length} messages');
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
    addMessage(type: 'bot', status: 'loading');

    emit(GeminiLoadingState(
      chatHistory: chatHistory,
    ));
    // question = userDescription;
    var result = await _geminiRepo.getRecommendedBook(
      userDescription: userDescription,
      books: books,
    );
    result.fold((failure) async {
      print('Error from Gemini Cubit: ${failure.errMessage}');
      final index = findLoadingBotIndex();
      if (index != -1) {
        chatHistory[index] = ChatMessageModel(
          type: 'bot',
          message: failure.errMessage,
          status: 'done',
        );
      }
      await saveChatHistory(
        chatHistory: chatHistory,
      );
      print('Chat history in error state: ${chatHistory.length} messages');
      emit(
        GeminiErrorState(
          errorMessage: failure.errMessage!,
          chatHistory: chatHistory,
        ),
      );
    }, (bookModel) async {
      final index = findLoadingBotIndex();
      if (index != -1) {
        chatHistory[index] = ChatMessageModel(
          type: 'bot',
          message: bookModel,
          status: 'done',
        );
      }
      print(
          'Chat history in success state: ${chatHistory.length} messages'); // addMessage(type: type, message: message)
      await saveChatHistory(
        chatHistory: chatHistory,
      );

      emit(
        GeminiLoadedState(bookModel, chatHistory),
      );
    });
  }
}

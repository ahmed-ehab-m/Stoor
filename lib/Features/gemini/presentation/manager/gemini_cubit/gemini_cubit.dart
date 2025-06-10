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
  List<ChatMessageModel> chatHistory = [];

  String userQuestion = '';
/////////////////////////////////////////////////
  void addMessage({required String type, dynamic message, String? status}) {
    final chatMessage =
        ChatMessageModel(type: type, message: message, status: status);

    chatHistory.insert(0, chatMessage);
  }

//////////////////////////////////////////////////
  ///
  Future<void> saveChatHistory(
      {required List<ChatMessageModel> chatHistory}) async {
    emit(GeminiMessageLoadingState());
    var result = await _geminiRepo.saveChatHistory(chatHistory);
    result.fold((failure) {
      emit(
        GeminiMessageSaveFailureState(
          errorMessage: failure.errMessage!,
        ),
      );
    }, (success) {
      emit(GeminiMessageSavedState());
    });
  }

/////////////////////////////////////////////////
  Future<void> getChatHistory() async {
    emit(GeminiChatHistoryLoadingState());
    var result = await _geminiRepo.getChatHistory();

    result.fold((failure) {
      emit(
        GeminiChatHistoryFailureState(failure.errMessage!),
      );
    }, (chathistory) {
      chatHistory = chathistory;
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

//////////////////////////////////////////////
  Future<void> getBookDescription({required BookModel book}) async {
    emit(GetBookDescriptionLoadingState());
    var result = await _geminiRepo.getBookDescription(book: book);
    result.fold((failure) {
      emit(
        GetBookDescriptionFailureState(message: failure.errMessage!),
      );
    }, (description) {
      emit(
        GetBookDescriptionLoadedState(bookDescription: description),
      );
    });
  }

/////////////////////////////////////////////
  Future<void> getRecommendedBook({
    required String userDescription,
    required List<BookModel> books,
  }) async {
    userQuestion = userDescription;
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
      await saveChatHistory(
        chatHistory: chatHistory,
      );

      emit(
        GeminiLoadedState(bookModel, chatHistory),
      );
    });
  }
}

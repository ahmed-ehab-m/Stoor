import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:dartz/dartz.dart';

abstract class GeminiRepo {
  Future<Either<Failure, List<BookModel?>>> getRecommendedBook(
      {required String userDescription, required List<BookModel> books});
//////////////////////////////////////////////////////
  Future<Either<Failure, String>> getBookDescription({required BookModel book});
//////////////////////////////////////////////////////

  Future<Either<Failure, void>> saveChatHistory(
      List<ChatMessageModel> chatHistory);
//////////////////////////////////////////////////////
  Future<Either<Failure, List<ChatMessageModel>>> getChatHistory();
}

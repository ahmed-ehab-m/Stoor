import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:dartz/dartz.dart';

abstract class GeminiRepo {
  Future<Either<Failure, List<Apibook?>>> getRecommendedBook(
      {required String userDescription, required List<Apibook> books});
//////////////////////////////////////////////////////
  Future<Either<Failure, String>> getBookDescription({required Apibook book});
//////////////////////////////////////////////////////

  Future<Either<Failure, void>> saveChatHistory(
      List<ChatMessageModel> chatHistory);
//////////////////////////////////////////////////////
  Future<Either<Failure, List<ChatMessageModel>>> getChatHistory();
}

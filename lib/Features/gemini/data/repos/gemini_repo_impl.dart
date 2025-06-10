import 'dart:convert';

import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/data/data_sources/local_data_source.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiRepoImpl implements GeminiRepo {
  final Gemini gemini;
  final LocalDatasource _localDatasource;
  final Connectivity connectivity;
  GeminiRepoImpl(this.gemini, this._localDatasource, this.connectivity);
  /////////////////////////////////////////////////////
  @override
  Future<Either<Failure, void>> saveChatHistory(
      List<ChatMessageModel> chatHistory) async {
    var cacheResult = await _localDatasource.saveGeminiChatHistory(chatHistory);
    return cacheResult.fold(
      (failure) => Left(failure),
      (_) => Right(null),
    );
  }

  ////////////////////////////////////////////////////
  @override
  Future<Either<Failure, List<ChatMessageModel>>> getChatHistory() async {
    var cacheResult = await _localDatasource.getGeminiChatHistory();
    return cacheResult.fold(
      (failure) => Left(failure),
      (chatHistory) => Right(chatHistory),
    );
  }

/////////////////////////////////////////////////
  @override
  Future<Either<Failure, List<BookModel?>>> getRecommendedBook({
    required String userDescription,
    required List<BookModel> books,
  }) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return left(
            ServerFailure('Check your Internet connection , and try again'));
      }

      if (books.isEmpty) {
        return left(
            ServerFailure('Check your Internet connection , and try again'));
      }
      // gemini.
      final promt = _buildSystemPromtRecommendation(
          books: books, userDescription: userDescription);
      final response = await gemini.prompt(parts: [Part.text(promt)]);
      String cleanedResponse = response?.output ?? '';
      cleanedResponse =
          cleanedResponse.replaceAll('```json', '').replaceAll('```', '');
      cleanedResponse = cleanedResponse.trim();

      final jsonData = jsonDecode(cleanedResponse);
      final selectedIds = jsonData.map((item) => item['id'] as String).toList();

      final selectedBooks =
          books.where((book) => selectedIds.contains(book.id)).toList();
      if (selectedBooks.isEmpty) {
        return left(ServerFailure(
            'No relevant books found ,try with different description.'));
      }
      return right(selectedBooks);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  ////////////////////////////////////////////////////
  static String _buildSystemPromtRecommendation(
      {required List<BookModel> books, required String userDescription}) {
    final buffer = StringBuffer();

    buffer.write(
        'You are a book recommendation assistant. Based on the user\'s description, recommend  one or more books from the following list:\n\n');

    for (var book in books) {
      buffer.write('- Title: ${book.volumeInfo.title}\n');
      buffer.write(
          '  Description: ${book.volumeInfo.description ?? "No description available"}\n');
      buffer.write('  ID: ${book.id}\n\n');
    }
    buffer.write('User description: "$userDescription"\n\n');
    buffer.write(
        'Choose the most relevant book from the list above based on the user description. ');
    buffer.write(
        'Return a JSON array of objects, each containing the "id" of a selected book, like this:\n');
    buffer.write('[{"id": "book_id1"}, {"id": "book_id2"}]\n');
    buffer.write(
        'If no books are relevant, return an empty array []. Ensure the response contains only the JSON array and no additional text.');
    return buffer.toString();
  }

////////////////////////////////////////////////
  @override
  Future<Either<Failure, String>> getBookDescription(
      {required BookModel book}) async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return left(
            ServerFailure('Check your Internet connection , and try again'));
      }
      final promt = _buildSystemPromtBookDescription(book: book);
      final response = await gemini.prompt(parts: [Part.text(promt)]);
      final cleanedResponse =
          response!.output!.substring(1, response.output!.length - 1).trim();
      if (cleanedResponse.isEmpty) {
        return left(ServerFailure('There is no description for this book.'));
      }
      return right(cleanedResponse);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  ///////////////////////////////////////////
  static String _buildSystemPromtBookDescription({required BookModel book}) {
    final buffer = StringBuffer();

    buffer.write(
        'You are a book recommendation assistant. Based on this book Details, search first and then create a new description (summary) for the following book:\n\n');

    buffer.write('- Title: ${book.volumeInfo.title}\n');
    buffer.write(
        '  Description: ${book.volumeInfo.description ?? "No description available"}\n');
    buffer.write(
        '  Author: ${book.volumeInfo.authors?.join(", ") ?? "No author available"}\n');
    buffer.write(
        'The summary should be a concise paragraph, limited to a maximum of 5 lines. ');

    buffer.write(
        'Return only the new summary as a plain text string, with no additional text or formatting (e.g., no JSON, no labels).');
    return buffer.toString();
  }
}

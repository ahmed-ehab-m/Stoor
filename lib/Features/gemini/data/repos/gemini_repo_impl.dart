import 'dart:convert';

import 'package:bookly_app/Features/gemini/data/repos/gemini_repo.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiRepoImpl implements GeminiRepo {
  final Gemini gemini;
  GeminiRepoImpl(this.gemini);
  @override
  Future<Either<Failure, BookModel?>> getRecommendedBook({
    required String userDescription,
    required List<BookModel> books,
  }) async {
    try {
      if (books.isEmpty) {
        return left(ServerFailure('No books available to recommend'));
      }
      final promt =
          _buildSystemPromt(books: books, userDescription: userDescription);
      final response = await gemini.prompt(parts: [Part.text(promt)]);
      String cleanedResponse = response?.output ?? '';
      print('response: $cleanedResponse');
      cleanedResponse =
          cleanedResponse.replaceAll('```json', '').replaceAll('```', '');
      cleanedResponse = cleanedResponse.trim();
      print('cleanedResponse: $cleanedResponse');
      final jsonData = jsonDecode(cleanedResponse ?? '');
      final selectedId = jsonData['id'] as String;
      final selectedBook = books.firstWhere((book) => book.id == selectedId,
          orElse: () => books.first);
      if (cleanedResponse.isEmpty) {
        return left(ServerFailure('Empty response from Gemini'));
      }
      return right(selectedBook);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static String _buildSystemPromt(
      {required List<BookModel> books, required String userDescription}) {
    //we want to build a string that will be the prompt for the AI to generate a story
    //the string consists of two parts: the context description and the response instruction
    //if the context description is null, we will use a default value
    //if the response instruction is null, we will use a default value
    //so we use the ?? operator to provide a default value if the parameter is null
    final buffer = StringBuffer();
    // buffer.write('' ??
    //     '''Based on the user's description, recommend a book and provide the response in JSON format with the following structure:''');
    // //we want to add a space between the context description and the response instruction
    // buffer.write(' ');
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
        'Return only a JSON object with the "id" of the selected book, like this:\n');
    buffer.write('{"id": "book_id"}\n');
    buffer.write(
        'Ensure the response contains only the JSON object and no additional text.');
    // buffer.write('''
    //             {
    //         "kind": ",
    //         "id": "",
    //         "etag": "",
    //         "selfLink": "",
    //         "volumeInfo": {
    //             "title": "",
    //             "subtitle": "",
    //             "authors": [
    //                 "",
    //                 ""
    //             ],
    //             "publisher": "",
    //             "publishedDate": "",
    //             "description": "",
    //             "industryIdentifiers": [
    //                 {
    //                     "type": "",
    //                     "identifier": ""
    //                 },
    //                 {
    //                     "type": "",
    //                     "identifier": ""
    //                 }
    //             ],
    //             "readingModes": {
    //                 "text": ,
    //                 "image":
    //             },
    //             "pageCount": ,
    //             "printType": "",
    //             "categories": [
    //                 ""
    //             ],
    //             "maturityRating": "",
    //             "allowAnonLogging": ,
    //             "contentVersion": "",
    //             "panelizationSummary": {
    //                 "containsEpubBubbles": ,
    //                 "containsImageBubbles":
    //             },
    //             "imageLinks": {
    //                 "smallThumbnail": "",
    //                 "thumbnail": ""
    //             },
    //             "language": "",
    //             "previewLink": "",
    //             "infoLink": "",
    //             "canonicalVolumeLink": ""
    //         },
    //         "saleInfo": {
    //             "country": "",
    //             "saleability": "",
    //             "isEbook": ,
    //             "listPrice": {
    //                 "amount": ,
    //                 "currencyCode": ""
    //             },
    //             "retailPrice": {
    //                 "amount": ,
    //                 "currencyCode": ""
    //             },
    //             "buyLink": ""
    //         },
    //         "accessInfo": {
    //             "country": "",
    //             "viewability": "",
    //             "embeddable": ,
    //             "publicDomain": ,
    //             "textToSpeechPermission": "",
    //             "epub": {
    //                 "isAvailable":
    //             },
    //             "pdf": {
    //                 "isAvailable": ,
    //                 "acsTokenLink": ""
    //             },
    //             "webReaderLink": "",
    //             "accessViewStatus": "",
    //             "quoteSharingAllowed":
    //         }
    //     },
    //     Ensure the response contains only the JSON object and no additional text.
    //     ''');
    //finally, we return the string that we have built
    return buffer.toString();
  }
}

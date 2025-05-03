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
    required String contextDescription,
  }) async {
    try {
      final promt = _buildSystemPromt(
        contextDescription: contextDescription,
      );
      final response = await gemini
          .prompt(parts: [Part.text(promt), Part.text(userDescription)]);
      String cleanedResponse = response?.output ?? '';
      print('response: $cleanedResponse');
      cleanedResponse =
          cleanedResponse.replaceAll('```json', '').replaceAll('```', '');
      cleanedResponse = cleanedResponse.trim();
      print('cleanedResponse: $cleanedResponse');
      final jsonData = jsonDecode(cleanedResponse ?? '');
      return right(BookModel.fromJson(jsonData));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  static String _buildSystemPromt({
    String? contextDescription,
  }) {
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
    buffer.write('''
                {
            "kind": ",
            "id": "",
            "etag": "",
            "selfLink": "",
            "volumeInfo": {
                "title": "",
                "subtitle": "",
                "authors": [
                    "",
                    ""
                ],
                "publisher": "",
                "publishedDate": "",
                "description": "",
                "industryIdentifiers": [
                    {
                        "type": "",
                        "identifier": ""
                    },
                    {
                        "type": "",
                        "identifier": ""
                    }
                ],
                "readingModes": {
                    "text": ,
                    "image": 
                },
                "pageCount": ,
                "printType": "",
                "categories": [
                    ""
                ],
                "maturityRating": "",
                "allowAnonLogging": ,
                "contentVersion": "",
                "panelizationSummary": {
                    "containsEpubBubbles": ,
                    "containsImageBubbles": 
                },
                "imageLinks": {
                    "smallThumbnail": "",
                    "thumbnail": ""
                },
                "language": "",
                "previewLink": "",
                "infoLink": "",
                "canonicalVolumeLink": ""
            },
            "saleInfo": {
                "country": "",
                "saleability": "",
                "isEbook": ,
                "listPrice": {
                    "amount": ,
                    "currencyCode": ""
                },
                "retailPrice": {
                    "amount": ,
                    "currencyCode": ""
                },
                "buyLink": ""
            },
            "accessInfo": {
                "country": "",
                "viewability": "",
                "embeddable": ,
                "publicDomain": ,
                "textToSpeechPermission": "",
                "epub": {
                    "isAvailable": 
                },
                "pdf": {
                    "isAvailable": ,
                    "acsTokenLink": ""
                },
                "webReaderLink": "",
                "accessViewStatus": "",
                "quoteSharingAllowed": 
            }
        },
        Ensure the response contains only the JSON object and no additional text.
        ''');
    //finally, we return the string that we have built
    return buffer.toString();
  }
}

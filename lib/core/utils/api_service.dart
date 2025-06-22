import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final _apibaseUrl = 'http://10.0.2.2:8000/api/v1/';
  final _favoritebaseurl = 'http://10.0.2.2:8000/api/v1/favorites/';

  final Dio _dio;
  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(_baseUrl + endpoint);
    return response.data;
  }

  //////////////////////////////////////////
  Future<void> post({required String bookId, required String userId}) async {
    var response = await _dio.post(
      _favoritebaseurl + bookId,
      data: {
        "user_id": userId,
      },
    );
  }

///////////////////////////////////////////////////////////
  Future<void> delete({required String bookId, required String userId}) async {
    var response = await _dio.delete(
      _favoritebaseurl + bookId,
      data: {
        "user_id": userId,
      },
    );
  }

////////////for test/////////////////////
  Future<Map<String, dynamic>> apiGet({required String endpoint}) async {
    var response = await _dio.get(_apibaseUrl + endpoint);

    // print(response.data);
    return response.data;
  }
}

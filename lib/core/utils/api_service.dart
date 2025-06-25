import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'http://10.0.2.2:8000/api/v1/';
  final _favoritebaseurl = 'http://10.0.2.2:8000/api/v1/favorites/';

  final Dio _dio;
  ApiService(this._dio);
  /////////////////////////////////////////
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(_baseUrl + endpoint);

    // print(response.data);
    return response.data;
  }

//////////////////////////////////////////////////
  Future<void> post({required String bookId, required String userId}) async {
    await _dio.post(
      _favoritebaseurl + bookId,
      data: {
        "user_id": userId,
      },
    );
  }

///////////////////////////////////////////////////////////
  Future<void> delete({required String bookId, required String userId}) async {
    await _dio.delete(
      _favoritebaseurl + bookId,
      data: {
        "user_id": userId,
      },
    );
  }
}

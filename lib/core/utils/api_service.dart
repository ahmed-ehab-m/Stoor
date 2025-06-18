import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final _apibaseUrl = 'http://10.0.2.2:8000/api/v1/books';

  final Dio _dio;
  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(_baseUrl + endpoint);
    return response.data;
  }

  Future<Map<String, dynamic>> apiGet({required String endpoint}) async {
    var response = await _dio.get(_apibaseUrl);

    print(response.data);
    return response.data;
  }
}

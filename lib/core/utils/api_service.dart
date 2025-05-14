import 'package:dio/dio.dart';

class ApiService {
  final _baseUrl = 'https://www.googleapis.com/books/v1/';
  final _hbaseUrl = 'https://hadeer.wuaze.com/api/v1/';

  final Dio _dio;
  ApiService(this._dio);
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(_baseUrl + endpoint);
    return response.data;
  }

  // Future<Map<String, dynamic>> hget({required String endpoint}) async {
  //   var response = await _dio.get('https://hadeer.wuaze.com/api/v1/books?i=1',
  //       options: Options(headers: {
  //         'Cookie': '77dfbe41c8719d9c5b17545fab0b39b8',
  //         'Accept': 'application/json',
  //       }));

  //   print(response.data);
  //   return response.data;
  // }
}

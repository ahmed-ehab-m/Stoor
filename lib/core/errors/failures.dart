import 'package:dio/dio.dart';

abstract class Failure {
  // message to show to the user
  final String? errMessage;
  const Failure(this.errMessage);
}

///////////////////////////////////////////
class CacheFailure extends Failure {
  CacheFailure(super.errMessage);
}

////////////////////////////////////
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromFirebaseAuthError(
    String errorCode,
  ) {
    switch (errorCode) {
      case 'user-not-found':
        return ServerFailure('User not found');
      case 'wrong-password':
        return ServerFailure('Wrong password');
      case 'email-already-in-use':
        return ServerFailure('Email already in use');
      case 'invalid-email':
        return ServerFailure('Invalid email address');
      default:
        return ServerFailure('Opps there was an error , Please try again');
    }
  }
  //dio error is enum data type
  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive Timeout');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResonse(
            dioError.response?.statusCode ?? 0, dioError.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request Cancelled');
      //soket error or no internet connection
      case DioExceptionType.connectionError:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('Connection Error, Please try again');
        }
      case DioExceptionType.unknown:
        return ServerFailure('Unknown Error, Please try again');
      default:
        return ServerFailure('Opps there was an error , Please try again');
    }
  }
  factory ServerFailure.fromResonse(int statusCode, dynamic resonse) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(resonse['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try again');
    } else if (statusCode == 500) {
      return ServerFailure('Internal server error , Please try again');
    } else {
      return ServerFailure('Opps there was an error , Please try again');
    }
  }
}

import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';

class ChatMessageModel {
  final dynamic message;
  final String type;
  final String? status;

  ChatMessageModel({required this.message, required this.type, this.status});
///////////////////////////////////////////////
  ///json encoding
  Map<String, dynamic> toJson() {
    return {'type': type, 'message': _encodeMessage(message), 'status': status};
  }

//////////////////////////////////////////
  dynamic _encodeMessage(dynamic message) {
    if (message is String) {
      return {'type': 'text', 'data': message};
    } else if (message is List<BookModel>) {
      return {
        'type': 'book',
        'data': message.map((book) => book.toJson()).toList()
      };
    }
  }

////////////////////////////////////////////
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    final messageData = json['message'];
    final messageType = messageData['type'];
    final messageContent = messageData['data'];
    if (messageType == 'text') {
      return ChatMessageModel(
        message: messageContent as String,
        type: json['type'],
        status: json['status'],
      );
    } else if (messageType == 'book') {
      final List<dynamic> bookJsonList = messageContent as List<dynamic>;
      final List<BookModel> books =
          bookJsonList.map((json) => BookModel.fromJson(json)).toList();
      return ChatMessageModel(
        message: books,
        type: json['type'],
        status: json['status'],
      );
    } else {
      return ChatMessageModel(
        message: 'null',
        type: json['type'],
        status: json['status'],
      );
    }
  }
}

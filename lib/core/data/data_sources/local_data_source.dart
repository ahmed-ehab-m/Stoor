import 'dart:io';
import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/core/errors/failures.dart';
import 'package:bookly_app/core/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class LocalDatasource {
  Future<Either<Failure, String>> saveImage(File image);
  Future<Either<Failure, String>> getProfileImagePath();
  Future<Either<Failure, void>> removeProfileImage();
  /////////////////////
  Future<void> saveInt(String key, int value);
  Future<int> getInt(String key);

  /////////////Theme index/////////////
  Future<void> saveThemeIndex(int value);
  Future<int> getThemeIndex();

  ///////////Font index///////////////
  Future<void> saveFontIndex(int value);
  Future<int> getFontIndex();

  //////////////////////////

  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);

  /////////////////////User data//////////////////////
  Future<Either<Failure, void>> saveUserData(UserModel user);
  Future<Either<Failure, UserModel?>>
      getUserData(); //for reading user data from cache
  Future<Either<Failure, void>> deleteUserData();
  ///////////////is first time and is logged in//////////////
  bool isFirstTime();
  void setFirstTimeDone();

  ////////////save Gemini chat history//////////////////
  Future<Either<Failure, void>> saveGeminiChatHistory(
      List<ChatMessageModel> chatHistory);
  Future<Either<Failure, List<ChatMessageModel>>> getGeminiChatHistory();
}

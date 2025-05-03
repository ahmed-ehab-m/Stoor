import 'package:bookly_app/Features/gemini/data/repos/gemini_repo_impl.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  // make a one time instance of the class
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<GeminiRepoImpl>(GeminiRepoImpl(
      Gemini.init(apiKey: 'AIzaSyCfLCKPziTSPaMPQAEyjP6INBHZlBUE47A')));

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt
          .get<ApiService>(), // get the instance of ApiService from the locator
    ),
  );
}

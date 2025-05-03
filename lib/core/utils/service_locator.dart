import 'package:bookly_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo_impl.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/core/helper/cache_helper.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
void setupServiceLocator() async {
  // make a one time instance of the class
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  await getIt.isReady<SharedPreferences>();

  getIt.registerSingleton<CacheHelper>(CacheHelper(
    getIt.get<
        SharedPreferences>(), // get the instance of SharedPreferences from the locator
  ));
  getIt.registerLazySingleton(() => FirebaseAuth.instance);

  getIt.registerSingleton<GeminiRepoImpl>(GeminiRepoImpl(
      Gemini.init(apiKey: 'AIzaSyCfLCKPziTSPaMPQAEyjP6INBHZlBUE47A')));

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt
          .get<ApiService>(), // get the instance of ApiService from the locator
    ),
  );

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
      getIt.get<
          FirebaseAuth>(), // get the instance of FirebaseAuth from the locator
      getIt.get<
          CacheHelper>(), // get the instance of CacheHelper from the locator
    ),
  );
}

import 'package:bookly_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo_impl.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/Features/settings/data/repos/settings_repo_impl.dart';
import 'package:bookly_app/core/data/data_sources/local_datasource.dart';
import 'package:bookly_app/core/helper/cache_helper.dart';
import 'package:bookly_app/core/utils/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
Future<void> setupServiceLocator() async {
  // make a one time instance of the class
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingletonAsync<SharedPreferences>(() async {
    print('SharedPreferences initialized');
    return await SharedPreferences.getInstance();
  });

  await getIt.isReady<SharedPreferences>();
  print('SharedPreferences ready');

  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => FirebaseFirestore.instance);

  getIt.registerSingleton<GeminiRepoImpl>(GeminiRepoImpl(
      Gemini.init(apiKey: 'AIzaSyCfLCKPziTSPaMPQAEyjP6INBHZlBUE47A')));

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt
          .get<ApiService>(), // get the instance of ApiService from the locator
    ),
  );
  getIt.registerSingleton<LocalDatasourceImpl>(LocalDatasourceImpl(
    getIt.get<
        SharedPreferences>(), // get the instance of SharedPreferences from the locator
  ));
  getIt.registerSingleton<SettingsRepoImpl>(SettingsRepoImpl(
    getIt.get<LocalDatasourceImpl>(),
  ));

  getIt.registerSingleton<AuthRepoImpl>(
    AuthRepoImpl(
        getIt.get<
            FirebaseAuth>(), // get the instance of FirebaseAuth from the locator
        // getIt.get<CacheHelper>(),
        getIt.get<FirebaseFirestore>(),
        getIt.get<
            LocalDatasourceImpl>() // get the instance of CacheHelper from the locator
        ),
  );
}

import 'package:bookly_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo_impl.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_state.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator(); // Initialize the service locator
  // Gemini.init(
  //     apiKey:
  //         'AIzaSyCfLCKPziTSPaMPQAEyjP6INBHZlBUE47A'); // Initialize the Gemini API
  runApp(const BooklyApp());
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthCubit(
                  getIt.get<AuthRepoImpl>(),
                )),
        BlocProvider<ChangeThemeCubit>(
          create: (context) => ChangeThemeCubit()..loadTheme(),
        ),
        BlocProvider<GeminiCubit>(
            create: (context) => GeminiCubit(getIt.get<GeminiRepoImpl>())),
        // . return value of the function , .. is the spread operator
        // after create cubit call this function to fetch data
        // best Practice is to call the function in the cubit constructor
        BlocProvider(
            create: (context) => FeaturedBooksCubit(
                  getIt.get<HomeRepoImpl>(),
                )..fetchFeaturedBooks()),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            getIt.get<HomeRepoImpl>(),
          )..fetchNewestBooks(),
        ),
      ],
      child: BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Bookly App',
            theme: ThemeData(
              brightness: BlocProvider.of<ChangeThemeCubit>(context).theme,
              scaffoldBackgroundColor:
                  BlocProvider.of<ChangeThemeCubit>(context).backgroundColor,
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

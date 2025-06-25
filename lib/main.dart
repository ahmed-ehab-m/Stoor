import 'package:bookly_app/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:bookly_app/Features/auth/presentation/manger/auth_cubit/auth_cubit.dart';
import 'package:bookly_app/Features/gemini/data/repos/gemini_repo_impl.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/rated_books_cubit/rated_books_cubit.dart';
import 'package:bookly_app/Features/settings/data/repos/settings_repo_impl.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/home/presentation/manager/all_books_cubit/all_books_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator(); // Initialize the service locator
  final settingsRepo = getIt.get<SettingsRepoImpl>();
  final savedThemeIndex = await settingsRepo.getThemeIndex();

  runApp(SkeletonizerConfig(
    data: SkeletonizerConfigData(
      effect: ShimmerEffect(
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: const Color(0xFFD3D3D3),
      ),
    ),
    child: BooklyApp(
      savedThemeIndex: savedThemeIndex,
    ),
  ));
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key, required this.savedThemeIndex});
  final int savedThemeIndex; // أضفنا savedThemeIndex كـ parameter
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookMarksBooksCubit(
            getIt.get<HomeRepoImpl>(),
            getIt.get<AuthRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              GeminiCubit(getIt.get<GeminiRepoImpl>())..getChatHistory(),
        ),
        BlocProvider(
            create: (context) => ProfileCubit(
                  getIt.get<AuthRepoImpl>(),
                )..loadProfile()),
        BlocProvider(
            create: (context) => PickImageCubit(
                  getIt.get<SettingsRepoImpl>(),
                )..getProfileImagePath()),
        BlocProvider(
          create: (context) => AuthCubit(
            getIt.get<AuthRepoImpl>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              ChangeSettingsCubit(getIt.get<SettingsRepoImpl>())
                ..changeTheme(savedThemeIndex),
        ),

        // . return value of the function , .. is the spread operator
        // after create cubit call this function to fetch data
        // best Practice is to call the function in the cubit constructor
        BlocProvider(
            create: (context) => AllBooksCubit(
                  getIt.get<HomeRepoImpl>(),
                )..fetchAllBooks()),
        BlocProvider(
            create: (context) => RatedBooksCubit(
                  getIt.get<HomeRepoImpl>(),
                )..fetcHighestRatedBooks()),
      ],
      child: BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Stoor',
            theme: ThemeData(
              brightness: BlocProvider.of<ChangeSettingsCubit>(context).theme,
              // scaffoldBackgroundColor:
              //     BlocProvider.of<ChangeSettingsCubit>(context).backgroundColor,
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

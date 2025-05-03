import 'package:bookly_app/Features/gemini/presentation/views/gemini_view.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly_app/Features/home/presentation/manager/similar_books_cubit.dart/similar_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/book_details_view.dart';
import 'package:bookly_app/Features/home/presentation/views/home_view.dart';
import 'package:bookly_app/Features/home/presentation/views/main_view.dart';
import 'package:bookly_app/Features/search/presentation/views/search_view.dart';
import 'package:bookly_app/Features/settings/presentation/views/settings_view.dart';
import 'package:bookly_app/Features/splash/presentation/views/onboarding_view.dart';
import 'package:bookly_app/Features/splash/presentation/views/splash_view.dart';
import 'package:bookly_app/core/utils/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const KOnboardingView = '/onboardingview';
  static const KMainView = '/mainview';
  static const KHomeView = '/homeview';
  static const KSettingsView = '/settingsview';
  static const KBookDetailsView = '/bookdetailsview';
  static const KSearchView = '/searchview';
  static const KGeminiView = '/geminiview';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: KOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: KMainView,
        builder: (context, state) => const MainView(),
      ),
      GoRoute(
        path: KSettingsView,
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: KHomeView,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: KGeminiView,
        builder: (context, state) => const GeminiView(),
      ),
      GoRoute(
        path: KBookDetailsView,
        builder: (context, state) => BlocProvider(
          create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
          child: BookDetailsView(
            bookModel: state.extra as BookModel?,
          ),
        ), // Replace with actual BookDetailsView
      ),
      GoRoute(
          path: KSearchView,
          builder: (context, state) {
            return SearchView(
              books: state.extra as List<BookModel>,
            ); // Replace with actual SearchView
          }),
    ],
  );
}

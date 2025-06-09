import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookRecommended extends StatelessWidget {
  const BookRecommended({super.key, required this.bookModel});
  final BookModel? bookModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.KBookDetailsView,
              extra: bookModel,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const SizedBox(
              //   height: 38,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: NewestBookImage(
                  imageUrl: bookModel?.volumeInfo.imageLinks.thumbnail ??
                      'https://www.freecodecamp.org/news/content/images/2023/01/Untitled-design-1.png',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                textAlign: TextAlign.center,
                bookModel?.volumeInfo.title ?? 'Book Title',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

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
          child: Container(
            // decoration: BoxDecoration(
            //   color: Colors.grey.withOpacity(0.1),
            //   borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(20),
            //     topLeft: Radius.circular(0),
            //     bottomRight: Radius.circular(20),
            //     bottomLeft: Radius.circular(20),
            //   ),
            //   // border: Border.all(color: Colors.red),
            // ),
            // decoration: BoxDecoration(
            //   color: Colors.grey.withOpacity(0.3),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(
                //   height: 38,
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

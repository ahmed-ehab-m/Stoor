import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/empty_books_widget.dart';
import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/library_title.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:flutter/material.dart';

class BookMarksViewBody extends StatelessWidget {
  const BookMarksViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeHelper screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSizeHelper.horizontalPadding,
          vertical: screenSizeHelper.homeVerticalPadding),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LibraryTitle(),
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: EmptyBooksWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

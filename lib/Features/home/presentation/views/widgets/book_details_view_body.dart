import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/books_details_section.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.bookModel});
  final BookModel? bookModel;
  @override
  Widget build(BuildContext context) {
    final ScreenSizeHelper screenSizeHelper =
        ScreenSizeHelper(context); //to use the screen size helper
    // var width = MediaQuery.of(context).size.width;
    //to use Expanded widget in the column, we need to wrap the column with a sliver widget
    //and use SliverFillRemaining to make the column take all the available space
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          //beccause customscroolview has a scroll body, we don't need to use true
          hasScrollBody: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenSizeHelper.homeVerticalPadding,
                horizontal: screenSizeHelper.horizontalPadding),
            child: Column(
              children: [
                CusomBookDetailsAppBar(),
                BookDetailsSection(
                  bookModel: bookModel,
                ),
                Expanded(
                  //to make the description take all the available space (Responsive)
                  child: const SizedBox(
                    height:
                        50, ////minimum height between the book action and the description
                  ),
                ),
                // SimilarBooksSection(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'package:bookly_app/Features/home/presentation/views/widgets/books_details_section.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_details_app_bar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/similar_books_section.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    //to use Expanded widget in the column, we need to wrap the column with a sliver widget
    //and use SliverFillRemaining to make the column take all the available space
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          //beccause customscroolview has a scroll body, we don't need to use true
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                CusomAppBar(),
                BookDetailsSection(),
                Expanded(
                  //to make the description take all the available space (Responsive)
                  child: const SizedBox(
                    height:
                        50, ////minimum height between the book action and the description
                  ),
                ),
                SimilarBooksSection(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

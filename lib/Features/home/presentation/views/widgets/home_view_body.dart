import 'package:bookly_app/Features/home/presentation/views/widgets/books_title.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_list_view.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HomeAppBar(),
                SizedBox(height: 10),
                BooksTitle(title: 'Popular Books'),
                SizedBox(height: 15),
                FeaturedBooksListView(),
                SizedBox(height: 20),
                BooksTitle(title: 'Newest'),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: NewestListView(),
        )
      ],
    );
  }
}

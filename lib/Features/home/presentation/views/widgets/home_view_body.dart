import 'package:bookly_app/Features/home/presentation/views/widgets/newest_list_view.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:bookly_app/core/utils/styles.dart';
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
                CustomAppBar(),
                SizedBox(height: 10),
                Text('Popular Books',
                    style: Styles.textStyle30
                        .copyWith(fontWeight: FontWeight.w900)),
                SizedBox(height: 15),
                FeaturedBooksListView(),
                SizedBox(height: 20),
                Text('Newest',
                    style: Styles.textStyle30
                        .copyWith(fontWeight: FontWeight.w900)),
                // BestSellerListView(),
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

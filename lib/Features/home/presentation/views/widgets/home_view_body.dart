import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_books_title.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_list_view.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is AllBooksFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        }
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const HomeAppBar(),
                    const SizedBox(height: 10),
                    Text(
                      'All Books',
                      style: Styles.textStyle30
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 15),
                    const FeaturedBooksListView(),
                    const SizedBox(height: 20),
                    const RatedBooksTitle(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: RatedListView(),
            )
          ],
        );
      },
    );
  }
}

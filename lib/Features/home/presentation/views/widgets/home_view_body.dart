import 'package:bookly_app/Features/home/presentation/manager/fetch_all_books_cubit/fetch_all_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_books_title.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_list_view.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/all_books_list_view.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllBooksCubit, FetchAllBooksState>(
      builder: (context, state) {
        if (state is FetchAllBooksFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
                    const AllBooksListView(),
                    const SizedBox(height: 20),
                    const RatedBooksTitle(),
                  ],
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              sliver: RatedListView(),
            )
          ],
        );
      },
    );
  }
}

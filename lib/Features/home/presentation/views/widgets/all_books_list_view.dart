import 'package:bookly_app/Features/home/presentation/manager/fetch_all_books_cubit/fetch_all_books_cubit.dart';
import 'package:bookly_app/core/widgets/all_books_list_item.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/all_books_skeleton.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/widgets/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AllBooksListView extends StatelessWidget {
  const AllBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAllBooksCubit, FetchAllBooksState>(
      builder: (context, state) {
        if (state is FetchAllBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.34,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                scrollDirection: Axis.horizontal,
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRouter.KBookDetailsView,
                        extra: state.books[index],
                      );
                    },
                    child: AllBooksListItem(
                      author: state.books[index].author?.name ?? '',
                      bookTitle: state.books[index].title ?? '',
                      imageUrl: state.books[index].image ?? '',
                    ),
                  );
                }),
          );
        } else if (state is FetchAllBooksFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else {
          return const FeaturedBookSkeleton();
        }
      },
    );
  }
}

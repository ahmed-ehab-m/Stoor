import 'package:bookly_app/Features/home/presentation/manager/fetch_rated_books_cubit/fetch_rated_books_cubit.dart';
import 'package:bookly_app/core/widgets/vertical_list_book_item.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_book_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RatedListView extends StatelessWidget {
  const RatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchRatedBooksCubit, FetchRatedBooksState>(
      builder: (context, state) {
        if (state is FetchHighestRatedBooksSuccess ||
            state is FetchLowestRatedBooksSuccess) {
          final books = (state is FetchHighestRatedBooksSuccess)
              ? state.books
              : (state as FetchLowestRatedBooksSuccess).books;
          // return const Skeletonizer.sliver(
          //   enabled: true,
          //   child: RatedBookSkeleton(),
          // );
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: VerticalListBookItem(bookModel: books[index]),
              );
            },
            childCount: books.length,
          ));
        } else if (state is FetchHighestRatedBooksFailure ||
            state is FetchLowestRatedBooksFailure) {
          final errorMessage = (state is FetchHighestRatedBooksFailure)
              ? state.errorMessage
              : (state as FetchLowestRatedBooksFailure).errorMessage;
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return const Skeletonizer.sliver(
            enabled: true,
            child: RatedBookSkeleton(),
          );
        }
      },
    );
  }
}

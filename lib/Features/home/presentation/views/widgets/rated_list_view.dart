import 'package:bookly_app/Features/home/presentation/manager/rated_books_cubit/rated_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_book_item.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/rated_book_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RatedListView extends StatelessWidget {
  const RatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatedBooksCubit, RatedBooksState>(
      builder: (context, state) {
        if (state is HighestRatedBooksSuccess ||
            state is LowestRatedBooksSuccess) {
          final books = (state is HighestRatedBooksSuccess)
              ? (state as HighestRatedBooksSuccess).books
              : (state as LowestRatedBooksSuccess).books;
          return SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RatedBookItem(bookModel: books[index]),
              );
            },
            childCount: books.length,
          ));
        } else if (state is HighestRatedBooksFailure ||
            state is LowestRatedBooksFailure) {
          final errorMessage = (state is HighestRatedBooksFailure)
              ? (state as HighestRatedBooksFailure).errorMessage
              : (state as LowestRatedBooksFailure).errorMessage;
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

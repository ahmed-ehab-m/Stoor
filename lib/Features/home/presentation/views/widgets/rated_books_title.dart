import 'package:bookly_app/Features/home/presentation/manager/rated_books_cubit/rated_books_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class RatedBooksTitle extends StatelessWidget {
  const RatedBooksTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatedBooksCubit, RatedBooksState>(
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              onPressed: () async {
                BlocProvider.of<RatedBooksCubit>(context).isHighestRated == true
                    ? await BlocProvider.of<RatedBooksCubit>(context)
                        .fetchLowestRatedBooks()
                    : await BlocProvider.of<RatedBooksCubit>(context)
                        .fetcHighestRatedBooks();
              },
              icon: const Icon(
                HugeIcons.strokeRoundedSorting05,
                // color: Colors.black54,
              ),
            ),
            Text(
              BlocProvider.of<RatedBooksCubit>(context).booksTitle,
              style: Styles.textStyle30.copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        );
      },
    );
  }
}

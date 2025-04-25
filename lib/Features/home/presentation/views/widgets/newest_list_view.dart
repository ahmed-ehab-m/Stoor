import 'package:bookly_app/Features/home/presentation/manager/newest_books_cubit/newest_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:bookly_app/core/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestListView extends StatelessWidget {
  const NewestListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        if (state is NewestBooksSuccess) {
          print(state.books.length);
          return ListView.separated(
            // physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: state.books.length,
            itemBuilder: (context, index) => BookListViewItem(
              bookModel: state.books[index],
            ),
          );
        } else if (state is NewestBooksFailure) {
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return CustomLoadingIndicator();
        }
      },
    );
  }
}

import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_list_item.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView(
      {super.key, required this.books, required this.searchQuery});
  final List<BookModel?>? books;
  final String searchQuery;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        if (state is GeminiLoadingState) {}
        return ListView.builder(
          itemCount: books!.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SearchListItem(
              bookModel: books![index],
              searchQuery: searchQuery,
            ),
          ),
        );
      },
    );
  }
}

import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_list_view_item.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.books});
  final List<BookModel?>? books;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
      ),
      itemCount: books!.length,
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemBuilder: (context, index) => GeminiListViewItem(
        bookModel: books![index],
      ),
    );
  }
}

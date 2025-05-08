import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.books});
  final List<BookModel?>? books;

  @override
  Widget build(BuildContext context) {
    print('books.length');
    print(books!.length);
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: books!.length,
      itemBuilder: (context, index) => BookListViewItem(
        bookModel: books![index],
      ),
    );
  }
}

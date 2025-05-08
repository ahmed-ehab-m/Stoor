import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key, required this.books});
  final List<BookModel> books;

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<BookModel> searchResult = [];
  @override
  void initState() {
    searchResult = widget.books;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(
            onCHanged: (value) {
              searchResult = searchBooks(widget.books, value);
              setState(() {});
            },
          ),
          SizedBox(height: 20),
          Text(
            'Search Result',
            style: Styles.textStyle18,
          ),
          SizedBox(height: 20),
          Expanded(
              child: SearchResultListView(
            books: searchResult,
          )),
        ],
      ),
    );
  }
}

List<BookModel> searchBooks(List<BookModel> books, String name) {
  if (name.isEmpty) {
    print('books is empty');
    return books;
  } else {
    return books
        .where((book) =>
            book.volumeInfo.title!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}

import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
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
  String searchQuery = '';

  @override
  void initState() {
    searchResult = widget.books;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenSizeHelper.horizontalPadding,
        vertical: screenSizeHelper.homeVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                ),
                color: const Color(0xFFA855F7),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CustomSearchTextField(
                  onCHanged: (value) {
                    searchQuery = value;
                    searchResult = searchBooks(widget.books, value);
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Search Result',
            style: Styles.textStyle18,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SearchResultListView(
              books: searchResult,
              searchQuery: searchQuery,
            ),
          ),
        ],
      ),
    );
  }
}

List<BookModel> searchBooks(List<BookModel> books, String name) {
  if (name.isEmpty) {
    return books;
  } else {
    return books
        .where((book) =>
            book.volumeInfo.title!.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}

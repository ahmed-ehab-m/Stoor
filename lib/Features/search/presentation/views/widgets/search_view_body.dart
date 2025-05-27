import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/custom_search_text_field.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
import 'package:bookly_app/core/utils/constants.dart';
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
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 30,
                ),
                color: kPrimaryColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: CustomSearchTextField(
                  onCHanged: (value) {
                    searchResult = searchBooks(widget.books, value);
                    setState(() {});
                  },
                ),
              ),
            ],
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

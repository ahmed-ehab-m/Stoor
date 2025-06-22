import 'package:bookly_app/Features/search/presentation/views/widgets/search_view_body.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.books});
  final List<Apibook> books;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SearchViewBody(
        books: books,
      )),
    );
  }
}

import 'package:bookly_app/core/widgets/vertical_list_book_item.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:flutter/cupertino.dart';

class BookMarksListView extends StatelessWidget {
  const BookMarksListView({super.key, required this.books});
  final List<BookModel> books;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: VerticalListBookItem(
            bookModel: books[index],
          ),
        ),
      ),
    );
  }
}

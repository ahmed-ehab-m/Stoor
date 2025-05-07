import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_action.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/core/helper/font_size_helper.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.bookModel});
  final BookModel? bookModel;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    print('Font Size');
    print(FontSizeHelper.descriptionFontSize);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          child: CustomBookImage(
            imageUrl: bookModel?.volumeInfo.imageLinks.thumbnail ??
                'https://www.freecodecamp.org/news/content/images/2023/01/Untitled-design-1.png',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          textAlign: TextAlign.center,
          bookModel?.volumeInfo.title ?? 'Book Title',
          style: TextStyle(
            fontSize: FontSizeHelper.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Opacity(
          opacity: 0.7,
          child: Text(
            bookModel?.volumeInfo.authors?.first ?? 'Author Name',
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
          rating: '4.5',
          reviewsCount: 100,
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          bookModel?.volumeInfo.description ??
              'No description available for this book',
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
          style: TextStyle(
            fontSize: FontSizeHelper.descriptionFontSize,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BookAction(
          bookModel: bookModel,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}

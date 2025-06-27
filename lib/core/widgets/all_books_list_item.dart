import 'package:bookly_app/core/utils/functions/get_short_title.dart';
import 'package:bookly_app/core/utils/functions/is_arabic.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';

class AllBooksListItem extends StatelessWidget {
  const AllBooksListItem(
      {super.key,
      required this.imageUrl,
      required this.bookTitle,
      required this.author});
  final String imageUrl;
  final String bookTitle;
  final String author;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: isArabic(bookTitle)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Expanded(child: CustomBookImage(imageUrl: imageUrl)),
          const SizedBox(height: 8),
          Text(
            getShortTitle(bookTitle),
            style: Styles.textStyle20.copyWith(
              fontWeight: FontWeight.w900,
              // color: kPrimaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            getShortTitle(author),
            style: Styles.textStyle14.copyWith(
                // color: Colors.grey,
                // color: kPrimaryColor,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

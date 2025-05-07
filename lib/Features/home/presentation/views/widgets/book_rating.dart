import 'package:bookly_app/core/helper/font_size_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  const BookRating(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      required this.rating,
      required this.reviewsCount});
  final MainAxisAlignment mainAxisAlignment;
  final String rating;
  final int reviewsCount;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          FontAwesomeIcons.solidStar,
          color: Colors.amber,
          size: 14,
        ),
        SizedBox(
          width: 6.3,
        ),
        Text(rating.toString(),
            style: TextStyle(
              fontSize: FontSizeHelper.descriptionFontSize,
            )),
        SizedBox(
          width: 5,
        ),
        Opacity(
          opacity: 0.7,
          child: Text('($reviewsCount)',
              style: TextStyle(
                fontSize: FontSizeHelper.descriptionFontSize,
              )),
        )
      ],
    );
  }
}

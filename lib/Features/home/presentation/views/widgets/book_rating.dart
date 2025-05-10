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
  // Widget? drawStars() {
  //   for (int i = 1; i < 4; i++) {
  //     return Icon(
  //       FontAwesomeIcons.solidStar,
  //       color: Colors.amber,
  //       size: 14,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size: 20,
        ),
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size: 20,
        ),
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size: 20,
        ),
        Icon(
          Icons.star_rate,
          color: Colors.amber,
          size: 20,
        ),
        Icon(
          Icons.star_half,
          color: Colors.amber,
          size: 20,
        ),
        // drawStars()!,
        SizedBox(
          width: 6.3,
        ),
        // Row(
        //   children: [
        //     Text(
        //       rating.toString(),
        //       style: TextStyle(
        //         fontSize: FontSizeHelper.descriptionFontSize,
        //       ),
        //     ),
        //     Text(
        //       ' /5',
        //       style: TextStyle(
        //           fontSize: FontSizeHelper.descriptionFontSize,
        //           color: Colors.grey),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   width: 5,
        // ),
        // Opacity(
        //   opacity: 0.7,
        //   child: Text('($reviewsCount)',
        //       style: TextStyle(
        //         fontSize: FontSizeHelper.descriptionFontSize,
        //       )),
        // )
      ],
    );
  }
}

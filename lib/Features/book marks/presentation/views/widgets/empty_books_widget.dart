import 'package:bookly_app/core/utils/styles.dart' show Styles;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyBooksWidget extends StatelessWidget {
  const EmptyBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You haven \'t added any bookmarks yet!',
            style: Styles.textStyle20,
          ),
          const SizedBox(height: 10), // مسافة صغيرة بين الجملتين
          Text(
            "Start adding your favorites and explore now!",
            style: Styles.textStyle16.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SvgPicture.asset(
            'assets/images/undraw_books_wxzz.svg',
            height: 200, // اضبط الحجم زي ما عايز
            width: 200,
          ),
        ],
      ),
    );
  }
}

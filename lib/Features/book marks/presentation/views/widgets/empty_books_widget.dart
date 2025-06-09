import 'package:bookly_app/core/utils/assets_data.dart';
import 'package:bookly_app/core/utils/styles.dart' show Styles;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyBooksWidget extends StatelessWidget {
  const EmptyBooksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // مسافة صغيرة بين الجملتين
        SvgPicture.asset(
          AssetsData.emptyBookMark, // اضبط الصورة زي ما عايز.',
          height: 200, // اضبط الحجم زي ما عايز
          width: 200,
        ),
        const SizedBox(height: 30),
        Text(
          'You haven \'t added any bookmarks yet!',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10), // مسافة صغيرة بين الجملتين
        Text(
          "Start adding your favorites and explore now!",
          style: Styles.textStyle16.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.rating,
    this.color,
  });
  final MainAxisAlignment mainAxisAlignment;
  final String rating;
  final Color? color;
  Widget? drawStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rating.round(); i++) // 3 نجوم
          const Icon(
            // Icons.star_rate,
            CupertinoIcons.star_fill,
            color: Colors.amber,
            size: 20,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double bookRating = double.parse(rating);

    return Row(
      spacing: 5,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Row(
          children: [
            Text(
              rating,
              style: TextStyle(
                fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                    .descriptionFontSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            drawStars(bookRating)!,
          ],
        ),
      ],
    );
  }
}

import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.rating,
  });
  final MainAxisAlignment mainAxisAlignment;
  final String rating;
  Widget? drawStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < rating.round(); i++) // 3 نجوم
          const Icon(
            Icons.star_rate,
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
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Colors.white,
                    Color(0xffFFD400),
                    // Blue
                  ],
                  tileMode: TileMode.repeated,
                ).createShader(bounds);
              },
              child: Text(
                'Rating: ',
                style: TextStyle(
                  fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                      .descriptionFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            drawStars(bookRating)!,
            const SizedBox(
              width: 5,
            ),
            Text(
              rating,
              style: TextStyle(
                fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                    .descriptionFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

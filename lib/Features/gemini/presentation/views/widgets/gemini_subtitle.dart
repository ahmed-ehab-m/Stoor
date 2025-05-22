import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class GeminiSubTitle extends StatelessWidget {
  const GeminiSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Hi! What can I recommend for you?',
          style: Styles.textStyle40
              .copyWith(fontWeight: FontWeight.w900, fontSize: 45),
        ),
      ],
    );
  }
}

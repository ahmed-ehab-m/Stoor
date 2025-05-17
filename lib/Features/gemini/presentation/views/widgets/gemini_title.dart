import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class GeminiTitle extends StatelessWidget {
  const GeminiTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Dive into your book journey with ',
          style: Styles.textStyle30,
        ),
        CustomShaderMask(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                HugeIcons.strokeRoundedGoogleGemini,
                size: 50,
                color: Colors.white,
              ),
              Text(
                ' Gemini',
                style: Styles.textStyle30.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

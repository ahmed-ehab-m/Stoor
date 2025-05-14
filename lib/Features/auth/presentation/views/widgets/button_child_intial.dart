import 'package:bookly_app/core/utils/assetsData.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ButtonChildIntial extends StatelessWidget {
  const ButtonChildIntial({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sign in with Google',
            style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        Image.asset(
          AssetsData.googleIcon,
          scale: 3,
        ),
      ],
    );
  }
}

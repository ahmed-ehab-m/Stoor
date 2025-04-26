import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.backGroundColor,
      required this.textColor,
      this.borderRadius,
      required this.text,
      this.fontSize,
      this.onPressed});
  final Color backGroundColor;
  final Color textColor;
  final BorderRadius? borderRadius;
  final String text;
  final double? fontSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backGroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Styles.textStyle18.copyWith(
            color: textColor, fontWeight: FontWeight.w900, fontSize: fontSize),
      ),
    );
  }
}

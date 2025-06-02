import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BooksTitle extends StatelessWidget {
  const BooksTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Styles.textStyle30.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

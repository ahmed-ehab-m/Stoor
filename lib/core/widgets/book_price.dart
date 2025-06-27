import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class BookPrice extends StatelessWidget {
  const BookPrice({super.key, this.price});
  final String? price;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$price EGP',
      style: Styles.textStyle16,
    );
  }
}

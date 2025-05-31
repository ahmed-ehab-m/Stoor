import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class LibraryTitle extends StatelessWidget {
  const LibraryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      ' My Library',
      style: Styles.textStyle24.copyWith(fontWeight: FontWeight.w900),
      // style: Styles.textStyle40.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

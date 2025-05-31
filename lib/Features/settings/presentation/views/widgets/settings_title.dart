import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Settings',
      style: Styles.textStyle24.copyWith(fontWeight: FontWeight.w900),
    );
  }
}

import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBookTitle extends StatelessWidget {
  const CustomBookTitle({super.key, this.bookTitle});
  final String? bookTitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      bookTitle ?? 'Book Title',
      style: TextStyle(
          fontSize: BlocProvider.of<ChangeSettingsCubit>(context).titleFontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white),
    );
  }
}

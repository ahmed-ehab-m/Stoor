import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    required this.validator,
    this.onSaved,
  });

  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: Styles.textStyle18.copyWith(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          cursorColor: kPrimaryColor,
          onSaved: onSaved,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.transparent,
            border: buildOutlineInputBorder(context),
            enabledBorder: buildOutlineInputBorder(context),
            focusedBorder: buildOutlineInputBorder(context),
          ),
          style: Styles.textStyle18, // Change the input text style here
        ),
      ],
    );
  }

  OutlineInputBorder buildOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
          color: BlocProvider.of<ChangeThemeCubit>(context).iconColor!),
    );
  }
}

import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onSaved,
    this.controller,
  });

  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: controller,
          cursorColor: kPrimaryColor,
          onSaved: onSaved,
          validator: validator,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Styles.textStyle18
                .copyWith(fontWeight: FontWeight.w400, color: Colors.grey),
            suffixIcon: suffixIcon,
            prefixIcon: Icon(
              hintText.contains('Password')
                  ? HugeIcons.strokeRoundedLockPassword
                  : hintText.contains('Email')
                      ? HugeIcons.strokeRoundedMail01
                      : hintText.contains('Name')
                          ? HugeIcons.strokeRoundedUser03
                          : HugeIcons.strokeRoundedUser03,
              color: BlocProvider.of<ChangeSettingsCubit>(context).iconColor,
            ),
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
          color: BlocProvider.of<ChangeSettingsCubit>(context).iconColor!),
    );
  }
}

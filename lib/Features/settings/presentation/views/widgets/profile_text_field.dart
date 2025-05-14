import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField(
      {super.key,
      this.fieldController,
      required this.onPressed,
      required this.validator});
  final TextEditingController? fieldController;

  final void Function() onPressed;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: fieldController,
      style: Styles.textStyle18,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            HugeIcons.strokeRoundedPencilEdit01,
          ),
        ),
        hintText: 'name',
        hintStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
        border: InputBorder.none,
      ),
    );
  }
}

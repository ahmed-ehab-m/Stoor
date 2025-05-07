import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, this.onPressed, this.onCHanged});
  final ValueChanged<String>? onCHanged;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Styles.textStyle18,
      onChanged: onCHanged,
      decoration: InputDecoration(
        ////normal state
        enabledBorder: buildOutlineInputBorder(),
        ////when user focuses on the text field
        focusedBorder: buildOutlineInputBorder(),
        hintText: 'Search',
        suffixIcon: Opacity(
          opacity: 0.8,
          child: IconButton(
            onPressed: onPressed,
            icon: const Icon(
              HugeIcons.strokeRoundedSearch01,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.grey, width: 1),
    );
  }
}

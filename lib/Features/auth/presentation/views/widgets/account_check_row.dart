import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class AccountCheckRow extends StatelessWidget {
  const AccountCheckRow(
      {super.key, required this.onPressed, required this.type});
  final void Function() onPressed;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            type == 'Sign Up'
                ? 'Don\'t have an account?'
                : 'Already have an account?',
            style: Styles.textStyle18),
        TextButton(
            onPressed: onPressed,
            child: Text(
              type == 'Sign Up' ? 'Sign Up' : 'Login',
              style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color.fromARGB(255, 228, 76, 255)),
            )),
      ],
    );
  }
}

import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomImageChoice extends StatelessWidget {
  const CustomImageChoice(
      {super.key,
      required this.choiceName,
      required this.iconData,
      this.onTap});
  final String choiceName;
  final IconData iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        spacing: 8,
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: Icon(
                iconData,
                // color: kPrimaryColor,
                size: 35,
              ),
            ),
          ),
          Text(
            choiceName,
            style: Styles.textStyle18.copyWith(
              fontWeight: FontWeight.normal,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSectionTitle extends StatelessWidget {
  const CustomSectionTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        Divider(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

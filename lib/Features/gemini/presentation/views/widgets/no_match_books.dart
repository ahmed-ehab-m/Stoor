import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoMatchBooks extends StatelessWidget {
  const NoMatchBooks({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.red.shade300.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  HugeIcons.strokeRoundedAiSearch02,
                  size: 35,
                  color: Colors.redAccent,
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    Text(
                      errorMessage.split(',')[0], // First sentence
                      style: TextStyle(
                        fontSize: 14,
                      ).copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      errorMessage.split(',')[1] ?? '', // Second sentence
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

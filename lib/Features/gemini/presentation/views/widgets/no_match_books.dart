import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NoMatchBooks extends StatelessWidget {
  const NoMatchBooks({super.key, required this.errorMessage});
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const BotIcon(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       const Color(0xFF9C27B0).withOpacity(0.4), // لون فاتح
                //       kPrimaryColor.withOpacity(0.6), // لون غامق
                //     ],
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //   ),
                //   borderRadius: BorderRadius.only(
                //     topRight: Radius.circular(20),
                //     topLeft: Radius.circular(0),
                //     bottomRight: Radius.circular(20),
                //     bottomLeft: Radius.circular(20),
                //   ),
                //   // border: Border.all(color: Colors.red),
                // ),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    errorMessage.contains(',') == true
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    errorMessage
                                        .split(',')[0], // First sentence
                                    style: Styles.textStyle20.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: Colors.redAccent.shade100,
                                    ),
                                  ),
                                  const Icon(
                                    HugeIcons.strokeRoundedSearchRemove,
                                    size: 25,
                                    color: Colors.redAccent,
                                  ),
                                ],
                              ),
                              Text(
                                errorMessage.split(',')[1], // Second sentence
                                style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                errorMessage, // First sentence
                                style: Styles.textStyle20.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.redAccent.shade100,
                                ),
                              ),
                              const Icon(
                                HugeIcons.strokeRoundedSearchRemove,
                                size: 25,
                                color: Colors.redAccent,
                              ),
                            ],
                          ),
                    // const SizedBox(width: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

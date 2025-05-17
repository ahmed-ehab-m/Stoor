import 'package:flutter/material.dart';

class InitialBookStateUi extends StatelessWidget {
  const InitialBookStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Stack(
          //   children: [
          //     CustomLogo(),
          //     Positioned(
          //       right: -1,
          //       bottom: -1,
          //       child: Icon(
          //         HugeIcons.strokeRoundedStars,
          //         size: 30,
          //         color: Colors.amber,
          //       ),
          //     )
          //   ],
          // ),

          // Lottie.asset(
          //   AssetsData
          //       .writingAnimation, // تأكد من إضافة هذا الأصل في assetsData
          //   height: 200,
          //   repeat: true,
          //   reverse: false,
          //   animate: true,
          // ),
          SizedBox(height: 20),
          // Text(
          //   'Write a book description\nand I\'ll suggest a book that fits',
          //   textAlign: TextAlign.center,
          //   style: Styles.textStyle20.copyWith(
          //     color: Colors.white,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}

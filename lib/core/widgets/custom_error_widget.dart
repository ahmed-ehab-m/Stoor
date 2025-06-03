import 'dart:ui' as ui;

import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20), // تأثير Blur
          child: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.purple.withOpacity(0.4), // لون بنفسجي فاتح
              //     Colors.black.withOpacity(0.6), // لون بنفسجي غامق
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              // ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 50,
                  spreadRadius: 50,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // لضبط الحجم حسب المحتوى
              children: [
                SvgPicture.asset(
                  'assets/images/errorRobot.svg',
                  height: 250,
                  width: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        errorMessage.split(',')[0], // First sentence
                        style: Styles.textStyle20
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 10), // مسافة صغيرة بين الجملتين

                      Text(
                        errorMessage.split(',')[1] ?? '', // Second sentence
                        style: Styles.textStyle16.copyWith(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

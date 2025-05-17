import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NoMatchesWidget extends StatelessWidget {
  const NoMatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              const Color(0xFF4285F4).withOpacity(0.1), // Light blue background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF4285F4), // Gemini blue border
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4285F4).withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off,
              size: 60,
              color: Color(0xFF4285F4),
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 12),
            Text(
              'No Matches Found',
              textAlign: TextAlign.center,
              style: Styles.textStyle18.copyWith(
                color: const Color(0xFF4285F4),
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 8),
            Text(
              'Try a new description',
              textAlign: TextAlign.center,
              style: Styles.textStyle14.copyWith(
                  // color: Colors.white,
                  ),
            ).animate().fadeIn(duration: 800.ms, delay: 200.ms),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

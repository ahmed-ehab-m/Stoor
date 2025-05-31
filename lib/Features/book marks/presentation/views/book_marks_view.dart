import 'package:bookly_app/Features/book%20marks/presentation/views/widgets/book_marks_view_body.dart';
import 'package:flutter/material.dart';

class BookMarksView extends StatelessWidget {
  const BookMarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: BookMarksViewBody()),
    );
  }
}

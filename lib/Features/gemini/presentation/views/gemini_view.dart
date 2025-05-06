import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_view_body.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';

class GeminiView extends StatelessWidget {
  const GeminiView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GeminiViewBody()),
    );
  }
}

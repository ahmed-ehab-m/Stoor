import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomQuestion extends StatelessWidget {
  const CustomQuestion({super.key, required this.question, this.color});
  final String question;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await BlocProvider.of<GeminiCubit>(context).getRecommendedBook(
          books: BlocProvider.of<FeaturedBooksCubit>(context).featuredBooks,
          userDescription: question,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          question,
          textAlign: TextAlign.start,
          style: Styles.textStyle18,
        ),
      ),
    );
  }
}

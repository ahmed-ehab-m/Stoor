import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiCustomTextField extends StatelessWidget {
  const GeminiCustomTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ]),
      child: TextField(
        controller: controller, // ربط الـ Controller
        style: Styles.textStyle18, // Change the input text style here
        decoration: InputDecoration(
          filled: true,
          fillColor: BlocProvider.of<ChangeThemeCubit>(context).backgroundColor,
          hintText: '...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                // colors: [kPrimaryColor, Colors.blue],
                colors: [
                  Color(0xFFEC4899), // Pink
                  Color(0xFFA855F7), // Purple
                  Color(0xFF3B82F6), // Blue
                ],
                tileMode: TileMode.repeated,
              ).createShader(bounds);
            },
            child: IconButton(
              onPressed: () async {
                print(controller.text);
                print('submitted');
                await BlocProvider.of<GeminiCubit>(context).getRecommendedBook(
                  books: BlocProvider.of<FeaturedBooksCubit>(context)
                      .featuredBooks,
                  userDescription: controller.text,
                );
              },
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

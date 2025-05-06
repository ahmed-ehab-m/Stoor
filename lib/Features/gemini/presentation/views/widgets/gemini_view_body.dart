import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeminiViewBody extends StatefulWidget {
  const GeminiViewBody({
    super.key,
  });
  @override
  State<GeminiViewBody> createState() => _GeminiViewBodyState();
}

class _GeminiViewBodyState extends State<GeminiViewBody> {
  BookModel? bookModel;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: BlocBuilder<GeminiCubit, GeminiState>(
        builder: (context, state) {
          if (state is GeminiLoadingState) {
            isloading = true;
            bookModel = null;
          }
          if (state is GeminiLoadedState) {
            bookModel = state.recommendedBook;
            isloading = false;
          }
          if (state is GeminiErrorState) {
            isloading = false;
          }
          return Stack(
            children: [
              Column(
                children: [
                  if (bookModel != null) BookListViewItem(bookModel: bookModel),
                  Spacer(),
                  TextField(
                    onSubmitted: (value) async {
                      print(value);
                      print('submitted');
                      await BlocProvider.of<GeminiCubit>(context)
                          .getRecommendedBook(
                        books: BlocProvider.of<FeaturedBooksCubit>(context)
                            .featuredBooks,
                        userDescription: 'recommend me a one book about $value',
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'write a brief description to search',
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
                        child: Icon(
                          Icons.send,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              if (isloading)
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: [
                          Color(0xFFEC4899), // Pink
                          Color(0xFFA855F7), // Purple
                          Color(0xFF3B82F6), // Blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        tileMode: TileMode.clamp,
                      ).createShader(bounds);
                    },
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

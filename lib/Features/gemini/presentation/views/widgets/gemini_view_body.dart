import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/manager/change_theme_cubit.dart/change_theme_state.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class GeminiViewBody extends StatefulWidget {
  const GeminiViewBody({
    super.key,
  });
  @override
  State<GeminiViewBody> createState() => _GeminiViewBodyState();
}

class _GeminiViewBodyState extends State<GeminiViewBody> {
  List<BookModel?>? books;
  bool isloading = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 50,
        bottom: 20,
        right: 20,
        left: 20,
      ),
      child: BlocBuilder<GeminiCubit, GeminiState>(
        builder: (context, state) {
          if (state is GeminiLoadingState) {
            isloading = true;
            books = null;
          }
          if (state is GeminiLoadedState) {
            books = state.recommendedBook;
            print('loaded');
            print(books);
            isloading = false;
          }
          if (state is GeminiErrorState) {
            print('error State');
            print(state.errorMessage);
            isloading = false;
          }
          return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: BlocProvider.of<ChangeThemeCubit>(context)
                              .backgroundColor ==
                          Colors.white
                      ? [
                          Color(0xFFF3E8FF), // Pastel Purple
                          Color(0xFFFCE7F3), // Pastel Pink
                          Color(0xFFE0F2FE), // Sky Blue
                        ]
                      : [
                          Colors.black,
                          // Color(0xFFEC4899), // Pink
                          Color.fromARGB(255, 31, 5, 56), // Purple
                          // Blue
                        ],
                )),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Dive into your book journey with ',
                          style: Styles.textStyle30,
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [
                                Color(0xFFEC4899), // Pink
                                Color(0xFFA855F7), // Purple
                                Color(0xFF3B82F6), // Blue
                              ],
                              tileMode: TileMode.repeated,
                            ).createShader(bounds);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedGoogleGemini,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                ' Gemini',
                                style: Styles.textStyle30
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        if (books != null && books!.isNotEmpty)
                          Expanded(
                              child: SearchResultListView(
                            books: books,
                          )),
                        if (books != null && books!.isEmpty)
                          Text(
                            'Oops, No Matches! Explore With a New Description',
                            textAlign: TextAlign.center,
                            style: Styles.textStyle18.copyWith(
                              color: Colors.purple.shade700,
                            ),
                          ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ]),
                          child: TextField(
                            controller: _controller, // ربط الـ Controller
                            style: Styles
                                .textStyle18, // Change the input text style here
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  BlocProvider.of<ChangeThemeCubit>(context)
                                      .backgroundColor,
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
                                    print(_controller.text);
                                    print('submitted');
                                    await BlocProvider.of<GeminiCubit>(context)
                                        .getRecommendedBook(
                                      books:
                                          BlocProvider.of<FeaturedBooksCubit>(
                                                  context)
                                              .featuredBooks,
                                      userDescription: _controller.text,
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
                            valueColor:
                                AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

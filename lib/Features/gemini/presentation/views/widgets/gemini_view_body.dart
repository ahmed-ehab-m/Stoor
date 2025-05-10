import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_circle_progress_indicator.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_cutom_text_field.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_theme_cubit.dart/change_theme_state.dart';
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
          // bottom: 20,
          // right: 20,
          // left: 20,
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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
                              Color(
                                  0xFF1A0B2E), // Deep Purple (قريب من الأسود بس فيه لمسة أرجواني)
                              Color(
                                  0xFF2A1B3D), // Dark Indigo (مزيج من الأرجواني والأزرق الغامق)
                              Color(
                                  0xFF4A1A3F), // Dark Plum (لمسة Pink غامقة للحيوية)
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
                        Expanded(
                            child: Column(children: [
                          if (books != null && books!.isNotEmpty)
                            Expanded(
                              child: SearchResultListView(
                                books: books,
                              ),
                            ),
                        ])),
                        if (books != null && books!.isEmpty)
                          Text(
                            'Oops, No Matches! Explore With a New Description',
                            textAlign: TextAlign.center,
                            style: Styles.textStyle18.copyWith(
                              color: Colors.purple.shade700,
                            ),
                          ),
                        // Spacer(),
                        GeminiCustomTextField(controller: _controller),
                      ],
                    ),
                    if (isloading) CustomCircleProgressIndicator(),
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

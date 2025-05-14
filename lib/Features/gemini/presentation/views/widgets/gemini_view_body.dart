import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_circle_progress_indicator.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_cutom_text_field.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/utils/assetsData.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';

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
      padding: const EdgeInsets.only(),
      child: BlocBuilder<GeminiCubit, GeminiState>(
        builder: (context, state) {
          if (state is GeminiLoadingState) {
            isloading = true;
            books = null;
          }
          if (state is GeminiLoadedState) {
            books = state.recommendedBook;
            isloading = false;
          }
          if (state is GeminiErrorState) {
            isloading = false;
          }
          return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: BlocProvider.of<ChangeSettingsCubit>(context)
                        .geminiColors,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Dive into your book journey with ',
                          style: Styles.textStyle30,
                        ),
                        CustomShaderMask(
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

                        // Spacer(),
                        GeminiCustomTextField(controller: _controller),
                      ],
                    ),
                    if (books != null && books!.isEmpty)
                      Center(
                        child: Text(
                          'Oops, No Matches! Explore With a New Description',
                          textAlign: TextAlign.center,
                          style: Styles.textStyle18.copyWith(
                              // color: Colors.purple.shade700,
                              ),
                        ),
                      ),
                    if (isloading)
                      Center(
                        child: Lottie.asset(
                          AssetsData.circleAnimation,
                          height: 200, // غيرها حسب المساحة اللي انت عايزها
                          repeat: true,
                          reverse: false,
                          animate: true,
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

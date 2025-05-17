import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/custom_loading_animation.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_cutom_text_field.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_title.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/initial_book_state_ui.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/no_matches_widget.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
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
                        GeminiTitle(),
                        SizedBox(height: 20),
                        // Text(
                        //   'Write a book description\nand I\'ll suggest a book that fits',
                        //   // textAlign: TextAlign.center,
                        //   style: Styles.textStyle20.copyWith(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            children: [
                              if (books != null && books!.isNotEmpty)
                                Expanded(
                                  child: SearchResultListView(
                                    books: books,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        GeminiCustomTextField(controller: _controller),
                      ],
                    ),
                    if (books == null && !isloading) InitialBookStateUi(),
                    if (books != null && books!.isEmpty) NoMatchesWidget(),
                    if (isloading) CustomLoadingAnimation(),
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

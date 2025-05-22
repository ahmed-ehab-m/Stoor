import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_chat.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_text_field.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_title.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/initial_book_state_ui.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
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

  // void onSend(String message) async {
  //   await BlocProvider.of<GeminiCubit>(context).sendQuestion(message);
  //   _controller.clear();
  // }

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
          // List<ChatMessageModel> chatHistory =
          //     BlocProvider.of<GeminiCubit>(context).chatHistory;
          if (state is GeminiLoadingState) {
            // chatHistory = state.chatHistory;
            isloading = true;
            books = null;
          } else if (state is GeminiLoadedState) {
            // chatHistory = state.chatHistory;
            isloading = false;

            books = state.recommendedBook;
          } else if (state is GeminiErrorState) {
            // chatHistory = state.chatHistory;
            isloading = false;
            books = null;
          }

          return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  // top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeminiTitle(),
                        //////////////////////////////
                        if (books == null && !isloading) InitialBookStateUi(),
                        ////////////////////////////////
                        SizedBox(height: 20),
                        // if (books != null && books!.isNotEmpty ||
                        //     (books != null && books!.isNotEmpty && isloading))
                        Expanded(
                          child: GeminiChat(
                              // chatHistory: chatHistory,
                              ),
                        ),
                        /////////////////////////////
                        // if (books == null || (books != null && books!.isEmpty))
                        //   Spacer(),
                        GeminiTextField(controller: _controller),
                      ],
                    ),
                    // if (books != null && books!.isEmpty) NoMatchesWidget(),
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

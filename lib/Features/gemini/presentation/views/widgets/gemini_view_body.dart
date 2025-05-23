import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
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
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        List<ChatMessageModel> chatHistory =
            BlocProvider.of<GeminiCubit>(context).chatHistory;
        return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 10,
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
                      if (chatHistory.isEmpty && !isloading)
                        InitialBookStateUi(),
                      ////////////////////////////////
                      Expanded(
                        child: GeminiChat(),
                      ),
                      /////////////////////////////
                      GeminiTextField(controller: _controller),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

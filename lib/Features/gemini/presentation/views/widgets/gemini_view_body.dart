import 'dart:ui';

import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_chat.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_text_field.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_title.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/initial_book_state_ui.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/helper/screen_size_helper.dart';
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
    final ScreenSizeHelper screenSizeHelper =
        ScreenSizeHelper(context); //to use the screen size helper
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        List<ChatMessageModel> chatHistory =
            BlocProvider.of<GeminiCubit>(context).chatHistory;
        return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.5,
                  focalRadius: 0.8,
                  colors: [
                    // Color.fromARGB(255, 1, 85, 202),
                    Color(0xFFA855F7), // Purple

                    BlocProvider.of<ChangeSettingsCubit>(context)
                        .backgroundColor!, // أزرق غامق (أعلى)
                    // أزرق غامق (أعلى)
                    // Color(0xFF3B82F6).withOpacity(0.7), // أزرق متوسط
                    // Color(0xFF60A5FA).withOpacity(0.3),
                    // Color(0xFF7C3AED).withOpacity(0.3),
                  ],
                  // stops: [0.0, 0.5, 1.0],
                  // stops: [0.0, 0.4, 0.8, 1.0],
                ),
              ),
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //     child: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.black.withOpacity(0.2),
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenSizeHelper.horizontalPadding,
                  vertical: screenSizeHelper.homeVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeminiTitle(),

                    //////////////////////////////
                    if (chatHistory.isEmpty && !isloading) InitialBookStateUi(),
                    ////////////////////////////////
                    Expanded(
                      child: GeminiChat(),
                    ),
                    /////////////////////////////
                    GeminiTextField(controller: _controller),
                  ],
                ),
              ),
              //     ),
              //   ),
              // ),
            );
          },
        );
      },
    );
  }
}

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
  const GeminiViewBody({super.key});
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
    final ScreenSizeHelper screenSizeHelper = ScreenSizeHelper(context);
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        List<ChatMessageModel> chatHistory =
            BlocProvider.of<GeminiCubit>(context).chatHistory;
        return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
          builder: (context, state) {
            return Stack(
              children: [
                // Radial Gradient أول
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: RadialGradient(
                      center: Alignment.bottomRight,
                      radius: 0.5,
                      focalRadius: 1,
                      colors: [
                        Color(0xFFA855F7).withOpacity(0.5), // Purple مع Opacity
                        BlocProvider.of<ChangeSettingsCubit>(context)
                            .backgroundColor!
                            .withOpacity(0.2), // لون الخلفية مع Opacity
                      ],
                    ),
                  ),
                ),
                // Radial Gradient تاني
                // Container(
                //   width: double.infinity,
                //   height: double.infinity,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     gradient: RadialGradient(
                //       center: Alignment.topRight,
                //       radius: 0.5,
                //       focalRadius: 0.8,
                //       colors: [
                //         Color(0xFFCE93D8)
                //             .withOpacity(0.1), // بنفسجي فاتح مع Opacity
                //         Colors.transparent, // يتلاشى للشفاف
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSizeHelper.horizontalPadding,
                    vertical: screenSizeHelper.homeVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeminiTitle(),
                      if (chatHistory.isEmpty && !isloading)
                        InitialBookStateUi(),
                      Expanded(
                        child: GeminiChat(),
                      ),
                      GeminiTextField(controller: _controller),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

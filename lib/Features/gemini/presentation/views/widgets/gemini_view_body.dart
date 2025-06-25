import 'package:bookly_app/Features/gemini/data/models/chat_message_model.dart';
import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_chat.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_text_field.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/gemini_title.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/initial_book_state_ui.dart';
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
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                // child: DynamicBg(
                //   duration: const Duration(seconds: 35),
                //   painterData: LavaPainterData(
                //     width: 250.0,
                //     widthTolerance: 75.0,
                //     growAndShrink: true,
                //     growthRate: 10.0,
                //     growthRateTolerance: 5.0,
                //     blurLevel: 25.0,
                //     numBlobs: 5,
                //     backgroundColor: Colors.transparent, // خلفية داكنة هادئة
                //     colors: [
                //       const Color(0xFF6B46C1)
                //           .withOpacity(0.6), // Purple غامق (مشتق من Indigo)
                //       const Color(0xFF8E44AD)
                //           .withOpacity(0.5), // Purple متوسط (مشتق من Amethyst)
                //       const Color(0xFFBB6BD9)
                //           .withOpacity(0.4), // Purple فاتح (مشتق من Lavender)
                //       const Color(0xFF3498DB)
                //           .withOpacity(0.3), // Blue فاتح للتوازن
                //     ],
                //     allSameColor: false,
                //     fadeBetweenColors: true,
                //     changeColorsTogether: false,
                //     speed: 20.0,
                //     speedTolerance: 5.0,
                //   ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSizeHelper.horizontalPadding,
                    vertical: screenSizeHelper.homeVerticalPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GeminiTitle(),
                      if (chatHistory.isEmpty && !isloading)
                        const InitialBookStateUi(),
                      const Expanded(
                        child: GeminiChat(),
                      ),
                      GeminiTextField(controller: _controller),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

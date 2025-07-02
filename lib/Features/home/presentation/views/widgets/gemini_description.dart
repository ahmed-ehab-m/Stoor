import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/gemini/presentation/views/widgets/bot_icon.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_bot_icon.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/core/widgets/custom_bottom_bar.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GeminiDescription extends StatelessWidget {
  const GeminiDescription({super.key, required this.isArabic});
  final bool isArabic;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeminiCubit, GeminiState>(
      builder: (context, state) {
        String description = '';
        bool enabled = false;
        if (state is GetBookDescriptionLoadingState) {
          description =
              'Loading... This is a placeholder text to simulate 5 lines of content. It helps maintain a consistent layout during loading. Please wait while the description is being generated. This ensures the skeleton looks good.';

          enabled = true;
        }
        if (state is GetBookDescriptionLoadedState) {
          description = state.bookDescription;

          enabled = false;
        }
        if (state is GetBookDescriptionFailureState) {
          description = state.message;
          enabled = false;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            children: [
              const CustomBotIcon(),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Skeletonizer(
                  enabled: enabled,
                  child: InkWell(
                    onTap: () {
                      showDescriptionBottomSheet(
                          context, description, isArabic);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      child: Skeleton.leaf(
                        child: Text(
                          description,
                          textAlign: isArabic ? TextAlign.end : TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                BlocProvider.of<ChangeSettingsCubit>(context)
                                    .descriptionFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showDescriptionBottomSheet(
    BuildContext context, String description, bool isArabic) {
  showModalBottomSheet(
    elevation: 0.8,
    context: context,
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomBottomBar(),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const BotIcon(),
              CustomShaderMask(
                child: Text(
                  ' Message',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                        .descriptionFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              textAlign: isArabic ? TextAlign.end : TextAlign.start,
              description,
              style: TextStyle(
                fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                    .descriptionFontSize,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

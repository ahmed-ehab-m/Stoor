import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
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
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xffFFD400),
                      // Blue
                    ],
                    tileMode: TileMode.repeated,
                  ).createShader(bounds);
                },
                child: const Icon(
                  HugeIcons.strokeRoundedRobot01,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Skeletonizer(
                  enabled: enabled,
                  child: Container(
                    // margin: const EdgeInsets.only(top: 10, bottom: 10),
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

                        // widget.bookModel?.description ??
                        //     'No description available yet',
                        textAlign: isArabic ? TextAlign.end : TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              BlocProvider.of<ChangeSettingsCubit>(context)
                                  .descriptionFontSize,
                          // color: Colors.grey[700],
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

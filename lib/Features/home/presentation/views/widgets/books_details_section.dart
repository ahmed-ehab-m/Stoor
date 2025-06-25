import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_action.dart';
import 'package:bookly_app/core/widgets/book_mark_icon.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/assets_data.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:bookly_app/core/widgets/custom_shader_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailsSection extends StatefulWidget {
  const BookDetailsSection({super.key, required this.bookModel});
  final BookModel? bookModel;

  @override
  State<BookDetailsSection> createState() => _BookDetailsSectionState();
}

class _BookDetailsSectionState extends State<BookDetailsSection> {
  @override
  void initState() {
    getBookDescription();
    super.initState();
  }

  Future<void> getBookDescription() async {
    await BlocProvider.of<GeminiCubit>(context)
        .getBookDescription(book: widget.bookModel!);
  }

  @override
  Widget build(BuildContext context) {
    String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';
    bool isBookmarked = BlocProvider.of<BookMarksBooksCubit>(context)
        .books
        .any((book) => book.id.toString() == widget.bookModel?.id.toString());
    // var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: const BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ShaderMask(
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
                          child: Text(
                            textAlign: TextAlign.center,
                            widget.bookModel?.title ?? 'Book Title',
                            style: TextStyle(
                              fontSize:
                                  BlocProvider.of<ChangeSettingsCubit>(context)
                                      .titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
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
                            child: Text(
                              'By: ',
                              style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                                  // fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                          Text(
                            widget.bookModel?.author?.name ?? 'Author Name',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
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
                            child: Text(
                              'Category: ',
                              style: Styles.textStyle18.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            widget.bookModel?.category?.name ?? 'No Category',
                            style: Styles.textStyle18.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BookRating(
                        mainAxisAlignment: MainAxisAlignment.start,
                        rating: widget.bookModel?.rating ?? '0.0',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
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
                              child: Text(
                                'Description: ',
                                style: Styles.textStyle18.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                // description,
                                widget.bookModel?.description ??
                                    'No description available yet',
                                textAlign: isArabic(
                                        widget.bookModel?.description ??
                                            'No description available yet')
                                    ? TextAlign.end
                                    : TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  fontSize:
                                      BlocProvider.of<ChangeSettingsCubit>(
                                              context)
                                          .descriptionFontSize,
                                  color: Colors.white,
                                  // color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<GeminiCubit, GeminiState>(
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
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
                                          textAlign: isArabic(widget
                                                      .bookModel?.description ??
                                                  'No description available yet')
                                              ? TextAlign.end
                                              : TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 6,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: BlocProvider.of<
                                                        ChangeSettingsCubit>(
                                                    context)
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
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BookAction(
                        bookModel: widget.bookModel,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: -1,
                  child: BookMarkIcon(
                      isBookmarked: isBookmarked,
                      bookId: widget.bookModel?.id.toString() ?? ''),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool isArabic(String text) {
    if (text.isEmpty) return false;
    return text.codeUnits[0] >= 0x600 && text.codeUnits[0] <= 0x6FF;
  }
}

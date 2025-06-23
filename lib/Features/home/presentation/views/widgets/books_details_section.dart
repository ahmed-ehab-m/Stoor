import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/book_marks_books_cubit/book_marks_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_action.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
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
  final Apibook? bookModel;

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
            // const SizedBox(
            //   height: 12,
            // ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 100),
            //   child: NewestBookImage(
            //     imageUrl:
            //         'http://10.0.2.2:8000/storage/${widget.bookModel?.image}' ??
            //             'https://www.freecodecamp.org/news/content/images/2023/01/Untitled-design-1.png',
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
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
                      BlocConsumer<BookMarksBooksCubit, BookMarksBooksState>(
                        listener: (context, state) {
                          // if (state is AddBookMarksBooksFailure) {
                          //   print('add to book marks failure ${state.errMessage}');
                          // } else if (state is DeleteBookMarksBooksFailure) {
                          //   print('delete from book marks failure ${state.errMessage}');
                          // }
                          // } else if (state is DeleteBookMarksBooksSuccess ||
                          //     state is AddBookMarksBooksSuccess) {
                          //   // إعادة تحميل القائمة بعد النجاح
                          //   BlocProvider.of<BookMarksBooksCubit>(context).fetchBookMark();
                          // }
                        },
                        builder: (context, state) {
                          // تحقق من القائمة المفضلة
                          // تحويل id لـ String
                          print(
                              'isBookmarked in first builder: $isBookmarked'); // للتحقق
                          if (state is AddBookMarksBooksLoading ||
                              state is DeleteBookMarksBooksLoading) {
                            isBookmarked = !isBookmarked;
                            print(
                                'in loading isBookmarked: $isBookmarked'); // للتحقق
                          }
                          if (state is AddBookMarksBooksSuccess) {
                            isBookmarked = true;
                            print(
                                'in add success isBookmarked: $isBookmarked'); // للتحقق
                          }
                          if (state is DeleteBookMarksBooksSuccess) {
                            isBookmarked = false;

                            print(
                                'in delete success isBookmarked: $isBookmarked'); // للتحقق
                          }

                          return IconButton(
                            onPressed: () async {
                              if (isBookmarked) {
                                // إذا موجود، احذفه
                                await BlocProvider.of<BookMarksBooksCubit>(
                                        context)
                                    .deleteBookMark(
                                        uid: uid,
                                        bookId:
                                            widget.bookModel?.id.toString() ??
                                                '');
                              } else {
                                // إذا مش موجود، أضفه
                                await BlocProvider.of<BookMarksBooksCubit>(
                                        context)
                                    .addtoBookMarks(
                                        uid: uid,
                                        bookId:
                                            widget.bookModel?.id.toString() ??
                                                '');
                              }
                              // تحديث القائمة بعد العملية
                              await BlocProvider.of<BookMarksBooksCubit>(
                                      context)
                                  .fetchBookMark();
                            },
                            icon: Icon(
                              size: 25,
                              isBookmarked
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                              color: isBookmarked
                                  ? Colors.amber
                                  : BlocProvider.of<ChangeSettingsCubit>(
                                          context)
                                      .iconColor,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.bookModel?.author?.name ?? 'Author Name',
                    style: Styles.textStyle18.copyWith(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const BookRating(
                    mainAxisAlignment: MainAxisAlignment.center,
                    rating: '4.5',
                    reviewsCount: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      // description,
                      widget.bookModel?.description ??
                          'No description available yet',
                      textAlign: isArabic(widget.bookModel?.description ??
                              'No description available yet')
                          ? TextAlign.end
                          : TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                            .descriptionFontSize,
                        color: Colors.white,
                        // color: Colors.grey[700],
                      ),
                    ),
                  ),
                  BlocBuilder<GeminiCubit, GeminiState>(
                    builder: (context, state) {
                      String description = '';
                      bool enabled = false;
                      if (state is GetBookDescriptionLoadingState) {
                        description =
                            'Loading... This is a placeholder text to simulate 5 lines of content. It helps maintain a consistent layout during loading. Please wait while the description is being generated. This ensures the skeleton looks good.';
                        print('description: $description');
                        enabled = true;
                      }
                      if (state is GetBookDescriptionLoadedState) {
                        description = state.bookDescription;
                        print('description: $description');

                        enabled = false;
                      }
                      if (state is GetBookDescriptionFailureState) {
                        description = state.message;
                        print('description: $description');
                        enabled = false;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const Icon(
                              HugeIcons.strokeRoundedRobot01,
                              color: Colors.white,
                              size: 35,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              // child: enabled
                              //     ? Lottie.asset(
                              //         AssetsData.typingAnimation2,
                              //         width: 50,
                              //         height: 50,
                              //         // fit: BoxFit.cover,
                              //       )
                              //     : Container(
                              //         margin: const EdgeInsets.only(
                              //             top: 10, bottom: 10),
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 20, vertical: 10),
                              //         decoration: BoxDecoration(
                              //           color: Colors.grey.withOpacity(0.1),
                              //           borderRadius: const BorderRadius.only(
                              //             topRight: Radius.circular(20),
                              //             topLeft: Radius.circular(0),
                              //             bottomRight: Radius.circular(20),
                              //             bottomLeft: Radius.circular(20),
                              //           ),
                              //         ),
                              //         child: Text(
                              //           description,
                              //           // widget.bookModel?.description ??
                              //           //     'No description available yet',
                              //           textAlign: isArabic(widget
                              //                       .bookModel?.description ??
                              //                   'No description available yet')
                              //               ? TextAlign.end
                              //               : TextAlign.start,
                              //           overflow: TextOverflow.ellipsis,
                              //           maxLines: 6,
                              //           style: TextStyle(
                              //             fontSize: BlocProvider.of<
                              //                     ChangeSettingsCubit>(context)
                              //                 .descriptionFontSize,
                              //             // color: Colors.grey[700],
                              //           ),
                              //         ),
                              //       ),
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
                                                ChangeSettingsCubit>(context)
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

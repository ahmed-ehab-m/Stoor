import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_description.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/author_name.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_action.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_category.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_title.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/gemini_description.dart';
import 'package:bookly_app/core/utils/functions/is_arabic.dart';
import 'package:bookly_app/core/widgets/book_mark_icon.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    // getBookPreview();
    super.initState();
  }

  Future<void> getBookDescription() async {
    await BlocProvider.of<GeminiCubit>(context)
        .getBookDescription(book: widget.bookModel!);
  }

  @override
  Widget build(BuildContext context) {
    String uid = BlocProvider.of<ProfileCubit>(context).uid ?? '';

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
                        child: Column(
                          children: [
                            CustomBookTitle(
                              bookTitle: widget.bookModel?.title,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            BookRating(
                              mainAxisAlignment: MainAxisAlignment.center,
                              rating: widget.bookModel?.rating ?? '0.0',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      BookDescription(
                        bookDescription: widget.bookModel?.description,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GeminiDescription(
                        isArabic: isArabic(widget.bookModel?.description ??
                            'No description available yet'),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      AuthorName(authorName: widget.bookModel?.author?.name),
                      const SizedBox(
                        height: 5,
                      ),
                      BookCategory(
                        categoryName: widget.bookModel?.category?.name,
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
                      color: Colors.white,
                      isRated: false,
                      uid: uid,
                      bookModel: widget.bookModel),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

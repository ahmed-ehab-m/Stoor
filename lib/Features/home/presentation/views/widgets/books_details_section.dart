import 'package:bookly_app/Features/gemini/presentation/manager/gemini_cubit/gemini_cubit.dart';
import 'package:bookly_app/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_action.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ChangeSettingsCubit, ChangeSettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: NewestBookImage(
                imageUrl: widget.bookModel?.volumeInfo.imageLinks.thumbnail ??
                    'https://www.freecodecamp.org/news/content/images/2023/01/Untitled-design-1.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              widget.bookModel?.volumeInfo.title ?? 'Book Title',
              style: TextStyle(
                fontSize:
                    BlocProvider.of<ChangeSettingsCubit>(context).titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Opacity(
              opacity: 0.7,
              child: Text(
                widget.bookModel?.volumeInfo.authors?.first ?? 'Author Name',
                style: Styles.textStyle18.copyWith(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            const BookRating(
              mainAxisAlignment: MainAxisAlignment.center,
              rating: '4.5',
              reviewsCount: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<GeminiCubit, GeminiState>(
              builder: (context, state) {
                String description = '';
                bool enabled = false;
                if (state is GetBookDescriptionLoadingState) {
                  description = 'Loading...';
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
                return Skeletonizer(
                  enabled: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      // description,
                      widget.bookModel?.volumeInfo.description ??
                          'No description available yet',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: BlocProvider.of<ChangeSettingsCubit>(context)
                            .descriptionFontSize,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),

            BookAction(
              bookModel: widget.bookModel,
            ),
            // const SizedBox(
            //   height: 30,
            // ),
          ],
        );
      },
    );
  }
}

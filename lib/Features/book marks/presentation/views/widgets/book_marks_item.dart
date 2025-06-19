import 'package:bookly_app/Features/home/presentation/manager/book_marks_books_cubit/book_marks_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_book_image.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_cubit.dart';
import 'package:bookly_app/Features/settings/presentation/manager/change_settings_cubit/change_settings_state.dart';
import 'package:bookly_app/Features/settings/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:bookly_app/core/models/apibook/apibook.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BookMarksItem extends StatefulWidget {
  const BookMarksItem({super.key, this.bookModel});
  final Apibook? bookModel;

  @override
  State<BookMarksItem> createState() => _BookMarksItemState();
}

class _BookMarksItemState extends State<BookMarksItem> {
  bool isBookmarked = true;
  bool isDeleting = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: Stack(
        children: [
          SizedBox(
            height: 180,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  NewestBookImage(imageUrl: widget.bookModel?.image ?? ''),
                  const SizedBox(width: 50),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          // isArabic(widget.bookModel?.title ?? '')
                          // ? CrossAxisAlignment.end
                          CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            widget.bookModel!.title ?? 'No title',
                            style: Styles.textStyle18,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.bookModel?.author?.name ?? 'No author',
                          style: Styles.textStyle14,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.bookModel?.price ?? 'No subtitle',
                          style: Styles.textStyle20,
                        ),
                        const Spacer(),
                        const BookRating(
                          mainAxisAlignment: MainAxisAlignment.end,
                          rating: '0.0',
                          reviewsCount: 0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: -1,
            // bottom:,
            child: BlocBuilder<BookMarksBooksCubit, BookMarksBooksState>(
              builder: (context, state) {
                if (state is DeleteBookMarksBooksLoading) {}
                return IconButton(
                  onPressed: () async {
                    setState(() {
                      isBookmarked = !isBookmarked;
                    });

                    await BlocProvider.of<BookMarksBooksCubit>(context)
                        .deleteBookMark(
                            uid: BlocProvider.of<ProfileCubit>(context).uid!,
                            bookId: widget.bookModel?.id.toString() ?? '');
                  },
                  icon: Icon(
                    isBookmarked
                        ? CupertinoIcons.bookmark_fill
                        : CupertinoIcons.bookmark,
                    color: isBookmarked
                        ? Colors.amber
                        : BlocProvider.of<ChangeSettingsCubit>(context)
                            .iconColor,
                    size: 20,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

bool isArabic(String text) {
  if (text.isEmpty) return false;
  return text.codeUnits[0] >= 0x600 && text.codeUnits[0] <= 0x6FF;
}

import 'package:bookly_app/Features/book%20marks/presentation/manager/book_marks_cubit/book_marks_cubit.dart';
import 'package:bookly_app/core/widgets/book_mark_icon.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/core/data/models/book_model/book_model.dart';
import 'package:bookly_app/core/utils/app_router.dart';
import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RatedBookItem extends StatefulWidget {
  const RatedBookItem({
    super.key,
    this.bookModel,
  });
  final BookModel? bookModel;
  @override
  State<RatedBookItem> createState() => _RatedBookItemState();
}

class _RatedBookItemState extends State<RatedBookItem> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    bool isBookmarked = BlocProvider.of<BookMarksBooksCubit>(context)
        .books
        .any((book) => book.id.toString() == widget.bookModel?.id.toString());

    return GestureDetector(
      onTap: () {
        GoRouter.of(context)
            .push(AppRouter.KBookDetailsView, extra: widget.bookModel);
      },
      child: BlocBuilder<BookMarksBooksCubit, BookMarksState>(
        builder: (context, state) {
          if (state is AddBookMarksLoading) {
            // إظهار مؤشر التحميل
          }
          if (state is DeleteBookMarksLoading) {
            _isDeleting = state.bookId == widget.bookModel?.id.toString();
          } else if (state is DeleteBookMarksSuccess ||
              state is DeleteBookMarksFailure) {
            _isDeleting = false;
            // إيقاف الانميشن
          }
          return Stack(
            children: [
              SizedBox(
                height: 180,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CustomBookImage(imageUrl: widget.bookModel?.image ?? ''),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.bookModel!.title ?? 'No title',
                                      style: Styles.textStyle18,
                                    ),
                                  ),
                                ],
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
                            Row(children: [
                              Text(
                                widget.bookModel?.price ?? 'free',
                                style: Styles.textStyle20,
                              ),
                            ]),
                            const Spacer(),
                            BookRating(
                              rating: widget.bookModel?.rating ?? '0.0',
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
                child: BookMarkIcon(
                    isBookmarked: isBookmarked,
                    bookId: widget.bookModel?.id.toString() ?? ''),
              ),
            ],
          );
        },
      ),
    );
  }
}
